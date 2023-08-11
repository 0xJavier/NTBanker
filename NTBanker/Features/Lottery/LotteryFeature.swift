//
//  LotteryFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import OSLog

/// Object that holds the Lottery feature's state, actions, and logic in the form of a reducer.
struct LotteryFeature: Reducer {
    struct State: Equatable {
        /// Represents the dollar amount for the parking lottery.
        var lotteryAmount: Int = 0
        /// Binding boolean that indicates if the view is reaching out to Firebase.
        @BindingState var isLoading = false
        /// Flag used to enable the collect button
        var shouldDisableCollectButton: Bool {
            isLoading || lotteryAmount <= 0
        }
        @PresentationState var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        /// Action called before the view is shown. Used to load data from Firebase.
        case retrieveLotteryAmount
        /// Action for when we receive a response when collecting the lottery for the user.
        case retrieveLotteryAmountResponse(TaskResult<Int>)
        /// Action for when a user taps the collect button.
        case collectButtonTapped
        case collectButtonTappedResponse(Error?)
        case alert(PresentationAction<Alert>)
        
        enum Alert: Equatable {
            case collectButtonTapped
        }
    }
    
    @Dependency(\.lotteryClient) var lotteryClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert(.presented(.collectButtonTapped)):
                state.isLoading = true
                return .run { [amount = state.lotteryAmount] send in
                    let response = try await self.lotteryClient.collectLottery(amount)
                    await send(.collectButtonTappedResponse(response))
                }
                
            case .alert:
                return .none
                
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
                Logger.lottery.error("Could not retrieve lottery amount: \(error.localizedDescription)")
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
                    TextState("Are you sure you want to collect lottery?")
                }
                
                return .none
                
            case .collectButtonTappedResponse(let error):
                state.isLoading = false
                if let error {
                    Logger.lottery.error("Could not collect lottery: \(error.localizedDescription)")
                    return .none
                }
                
                state.alert = AlertState {
                    TextState("Success!")
                }
                
                state.lotteryAmount = 0
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}
