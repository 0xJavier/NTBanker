//
//  HomeFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture
import OSLog

struct HomeFeature: Reducer {
    struct State: Equatable {
        /// Currently logged in user.
        var user = User.placeholder
        /// State for the `QuickActionFeature`.
        var quickActions = QuickActionFeature.State()
        /// State for the `TransactionFeature`.
        var transactions = TransactionFeature.State()
    }
    
    enum Action {
        /// Action used for the main view to start work when the view appears.
        case viewOnAppear
        /// Starts a stream from Firebase to listen to any updates to the logged in user.
        case streamUser
        /// Handles the response for each update from the user stream. Will either receive an updated user or an error.
        case userResponse(TaskResult<User>)
        /// Actions associated with the `QuickActionFeature`.
        case quickActions(QuickActionFeature.Action)
        /// Actions associated with the `TransactionFeature`.
        case transactions(TransactionFeature.Action)
    }
    
    @Dependency(\.homeClient) var homeClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewOnAppear:
                return .send(.streamUser)
                
            case .streamUser:
                return .run { send in
                    for try await user in await self.homeClient.streamUser() {
                        await send(.userResponse(.success(user)))
                    }
                } catch: { error, send in
                    await send(.userResponse(.failure(error)))
                }
                
            case .userResponse(.success(let user)):
                state.user = user
                return .none
                
            case .userResponse(.failure(let error)):
                Logger.home.error("User stream threw an error: \(error.localizedDescription)")
                return .none
                
            case .quickActions, .transactions:
                // Should be handled in the scoped domain.
                return .none
            }
        }
        
        Scope(state: \.quickActions, action: /Action.quickActions) {
            QuickActionFeature()
        }
        
        Scope(state: \.transactions, action: /Action.transactions) {
            TransactionFeature()
        }
    }
}
