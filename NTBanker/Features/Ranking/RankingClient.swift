//
//  RankingClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture

/// Main interface for the `RankingClient`
struct RankingClient: DependencyKey {
    /// Calls to Firebase and returns a ordered list of active players in descending order based on a player's balance
    var fetchUsers: @Sendable () async throws -> [User]
}

extension DependencyValues {
    /// Registers `RankingClient` with TCA's dependency injection system
    var rankingClient: RankingClient {
        get { self[RankingClient.self] }
        set { self[RankingClient.self] = newValue }
    }
}
