//
//  HomeFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture
import OSLog

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        var user = User.placeholder
        /// State for the `QuickActionFeature`.
        var quickActions = QuickActionFeature.State()
        /// State for the `TransactionFeature`.
        var transactions = TransactionFeature.State()
    }
    
    enum Action {
        case viewOnAppear
        case streamUser
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
                return .none
            }
        }
        
        Scope(state: \.quickActions, action: \.quickActions) {
            QuickActionFeature()
        }
        
        Scope(state: \.transactions, action: \.transactions) {
            TransactionFeature()
        }
    }
}
