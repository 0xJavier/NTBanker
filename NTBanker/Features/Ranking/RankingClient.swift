//
//  RankingClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture

/// Main interface for the Ranking Feature.
struct RankingClient: DependencyKey {
    /// Reach out to firebase and return a ordered list of all current users in descending order based on a player's balance.
    var fetchUsers: @Sendable () async throws -> [User]
}

extension DependencyValues {
    var rankingClient: RankingClient {
        get { self[RankingClient.self] }
        set { self[RankingClient.self] = newValue }
    }
}
