//
//  RankingFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import OSLog

@Reducer
struct RankingFeature {
    @ObservableState
    struct State: Equatable {
        var users = [User]()
    }
    
    enum Action {
        case viewOnAppear
        case fetchUsers
        case fetchUsersResponse(TaskResult<[User]>)
    }
    
    @Dependency(\.rankingClient) var rankingClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewOnAppear:
                return .send(.fetchUsers)
                
            case .fetchUsers:
                return .run { send in
                    let response = await TaskResult { try await self.rankingClient.fetchUsers() }
                    await send(.fetchUsersResponse(response))
                }

            case .fetchUsersResponse(.success(let users)):
                state.users = users
                return .none
                
            case .fetchUsersResponse(.failure(let error)):
                Logger.ranking.error("Could not fetch users for ranking list: \(error.localizedDescription)")
                state.users = []
                return .none
            }
        }
    }
}
