//
//  SendMoneyClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture

extension SendMoneyClient {
    /// Mock version of `SendMoneyClient` that is used to power SwiftUI previews
    static var previewValue: Self {
        return Self(
            getActiveUsers: {
                try await Task.sleep(for: .milliseconds(500))
                return User.mockUserList
            },
            
            sendMoney: { _, _ in
                return nil
            }
        )
    }
}

extension SendMoneyClient {
    /// Mock version of `SendMoneyClient` used when running tests.
    static let testValue = Self(
        getActiveUsers: unimplemented("\(Self.self).getActiveUsers"),
        sendMoney: unimplemented("\(Self.self).sendMoney")
    )
}
