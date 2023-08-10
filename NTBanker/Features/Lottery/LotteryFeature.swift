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
    }
    
    enum Action {
        /// Action called before the view is shown. Used to load data from Firebase.
        case retrieveLotteryAmount
        /// Action for when we receive a response when collecting the lottery for the user.
        case retrieveLotteryAmountResponse(TaskResult<Int>)
        /// Action for when a user taps the collect button.
        case collectButtonTapped
        ///
        case collectButtonTappedResponse(Error?)
    }
    
    @Dependency(\.lotteryClient) var lotteryClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
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
                state.isLoading = true
                return .run { [amount = state.lotteryAmount] send in
                    let response = try await self.lotteryClient.collectLottery(amount)
                    await send(.collectButtonTappedResponse(response))
                }
                
            case .collectButtonTappedResponse(let error):
                state.isLoading = false
                if let error {
                    Logger.lottery.error("Could not collect lottery: \(error.localizedDescription)")
                    return .none
                }
                
                Logger.lottery.info("Successfully collected lottery")
                state.lotteryAmount = 0
                return .none
            }
        }
    }
}
