//
//  RankingFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import OSLog

struct RankingFeature: Reducer {
    struct State: Equatable {
        /// Current list of all users playing. Retrieved from Firebase in descending order by user's balance.
        var users = [User]()
    }
    
    enum Action {
        /// Action for when the ranking screen appears. Calls to Firebase for an  up-to-date list of all players.
        case fetchUsers
        /// Action for the response from getting a list of users from Firebase.
        /// Will return a list of users or an error. If an error occurs, we log it and return an empty list of users.
        case fetchUsersResponse(TaskResult<[User]>)
    }
    
    @Dependency(\.rankingClient) var rankingClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
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
