//
//  RankingClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture

struct RankingClient: DependencyKey {
    var fetchUsers: @Sendable () async throws -> [User]
}

extension RankingClient {
    static let liveValue = Self(
        fetchUsers: {
            try await Task.sleep(for: .milliseconds(1_100))
            return User.mockUserList
        }
    )
}

extension RankingClient {
    static let previewValue = Self(
        fetchUsers: {
            try await Task.sleep(for: .milliseconds(1_100))
            return User.mockUserList
        }
    )
}

extension RankingClient {
    static let testValue = Self(
        fetchUsers: unimplemented("\(Self.self).fetchUsers")
    )
}

extension DependencyValues {
    var rankingClient: RankingClient {
        get { self[RankingClient.self] }
        set { self[RankingClient.self] = newValue }
    }
}
