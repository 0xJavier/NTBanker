//
//  RankingClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import ComposableArchitecture

extension RankingClient {
    /// Mock version of `RankingClient` that is used to power SwiftUI previews.
    static let previewValue = Self(
        fetchUsers: {
            try await Task.sleep(for: .milliseconds(500))
            return User.mockUserList
        }
    )
}

extension RankingClient {
    /// Mock version of `RankingClient` used when running tests.
    static let testValue = Self(
        fetchUsers: unimplemented("\(Self.self).fetchUsers")
    )
}
