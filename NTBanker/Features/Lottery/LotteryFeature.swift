//
//  LotteryFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import OSLog

/// Reducer containing state, actions, and the main reducer for `LotteryFeature`.
struct LotteryFeature: Reducer {
    struct State: Equatable {
        /// Integer representing the lottery amount.
        var lotteryAmount: Int = 0
        /// Flag used to indicate when the feature is fetching data.
        @BindingState var isLoading = false
        /// Alert state used to indicate when we show a user-facing alert.
        @PresentationState var alert: AlertState<Action.Alert>?
        
        /// Flag indicating if the main collect button should be disabled.
        var shouldDisableCollectButton: Bool {
            isLoading || lotteryAmount <= 0
        }
    }
    
    enum Action {
        /// Action used for the main view to start work when the view appears. Created to make the call site in the view more generic versus
        /// calling a specific action, allowing us to modify one action in future PRs.
        case viewOnAppear
        /// Calls to firebase to get the up-to-date lottery amount to be shown.
        case retrieveLotteryAmount
        /// Handles the response from fetching the lottery amount. If successful, we update the lottery amount state to reflect in the UI.
        /// Otherwise, we reset the amount to 0, log the error, and present an alert.
        case retrieveLotteryAmountResponse(TaskResult<Int>)
        /// Action for when a user taps the collect button.
        case collectButtonTapped
        /// Handles the response when a user taps the button. If successful, we show an alert with a success message.
        /// Otherwise, we reset the amount to 0, log the error, and present an alert.
        case collectButtonTappedResponse(Error?)
        /// Action responsible for handling user input when it comes to user-facing alerts.
        case alert(PresentationAction<Alert>)
        
        /// Collection of actions we can do when presenting a user-facing alert.
        enum Alert: Equatable {
            /// Main action for when a user confirms they want to collect the lottery.
            case collectButtonTapped
        }
    }
    
    @Dependency(\.lotteryClient) var lotteryClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewOnAppear:
                return .send(.retrieveLotteryAmount)
                                
            case .retrieveLotteryAmount:
                state.isLoading = true
                return .run { send in
                    let response = await TaskResult { try await self.lotteryClient.retrieveLottery() }
                    await send(.retrieveLotteryAmountResponse(response))
                }
                
            case .retrieveLotteryAmountResponse(.success(let amount)):
                state.isLoading = false
                state.lotteryAmount = amount
                return .none
                
            case .retrieveLotteryAmountResponse(.failure(let error)):
                state.isLoading = false
                state.lotteryAmount = 0
                Logger.lottery.error("Could not retrieve lottery amount: \(error.localizedDescription)")
                state.alert = AlertState {
                    TextState("Could not get lottery amount at this time. Please try again.")
                }
                return .none
                
            case .collectButtonTapped:
                state.alert = AlertState {
                    TextState("Collect lottery")
                } actions: {
                    ButtonState(role: .cancel) {
                        TextState("Cancel")
                    }
                    
                    ButtonState(action: .collectButtonTapped) {
                        TextState("Collect")
                    }
                } message: {
                    TextState("Are you sure you want to collect the lottery?")
                }
                
                return .none
                
            case .collectButtonTappedResponse(let error):
                state.isLoading = false
                if let error {
                    state.lotteryAmount = 0
                    Logger.lottery.error("Could not collect lottery: \(error.localizedDescription)")
                    state.alert = AlertState {
                        TextState("Could not collect the lottery at this time. Please try again")
                    }
                    return .none
                }
                
                state.lotteryAmount = 0
                state.alert = AlertState {
                    TextState("Success!")
                }
                return .none
                
            case .alert(.presented(.collectButtonTapped)):
                state.isLoading = true
                return .run { [amount = state.lotteryAmount] send in
                    let response = try await self.lotteryClient.collectLottery(amount)
                    await send(.collectButtonTappedResponse(response))
                }
                
            case .alert:
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}
