//
//  LotteryFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture

/// Object that holds the Lottery feature's state, actions, and logic in the form of a reducer.
struct LotteryFeature: Reducer {
    struct State: Equatable {
        /// Represents the dollar amount for the parking lottery.
        var lotteryAmount: Int = 0
        /// Binding boolean that indicates if the view is reaching out to Firebase.
        @BindingState var isLoading = false
    }
    
    enum Action {
        /// Action called before the view is shown. Used to load data from Firebase.
        case viewWillAppear
        /// Action for when a user taps the collect button.
        case collectButtonTapped
        /// Action for when we receive a response when collecting the lottery for the user.
        case lotteryResponse(Int)
    }
    
    @Dependency(\.lotteryClient) var lotteryClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewWillAppear:
                return .none
                
            case .collectButtonTapped:
                state.isLoading = true
                return .run { send in
                    let amount = try await self.lotteryClient.retrieveLottery()
                    await send(.lotteryResponse(amount))
                }
                
            case .lotteryResponse(let amount):
                state.isLoading = false
                state.lotteryAmount = amount
                return .none
            }
        }
    }
}
