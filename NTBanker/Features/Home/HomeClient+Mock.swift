//
//  HomeClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture

extension HomeClient {
    static let previewValue = Self(
        streamUser: {
            try await Task.sleep(for: .milliseconds(1_100))
            return User.placeholder
        },
        streamTransactions: {
            try await Task.sleep(for: .milliseconds(1_100))
            return Transaction.mockList
        }
    )
}

extension HomeClient {
    static let testValue = Self(
        streamUser: unimplemented("\(Self.self).streamUser"),
        streamTransactions: unimplemented("\(Self.self).streamTransactions")
    )
}
