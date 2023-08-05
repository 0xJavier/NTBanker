//
//  RankingFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture

struct RankingFeature: Reducer {
    struct State: Equatable {
        var users = [User]()
    }
    
    enum Action {
        case fetchUsers
        case fetchUsersResponse([User])
    }
    
    @Dependency(\.rankingClient) var rankingClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchUsers:
                return .run { send in
                    let users = try await self.rankingClient.fetchUsers()
                    await send(.fetchUsersResponse(users))
                }
            case .fetchUsersResponse(let users):
                state.users = users
                return .none
            }
        }
    }
}
