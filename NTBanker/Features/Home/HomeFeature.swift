//
//  HomeFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture

struct HomeFeature: Reducer {
    struct State: Equatable {
        var user = User.placeholder
        var quickActions = QuickActionFeature.State()
        var transactions = TransactionFeature.State()
    }
    
    enum Action {
        case streamUser
        case userResponse(TaskResult<User>)
        case quickActions(QuickActionFeature.Action)
        case transactions(TransactionFeature.Action)
    }
    
    @Dependency(\.homeClient) var homeClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
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
                print("ERROR: \(error.localizedDescription)")
                return .none
                
            default:
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
