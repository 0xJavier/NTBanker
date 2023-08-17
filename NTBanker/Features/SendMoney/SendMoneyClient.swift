//
//  SendMoneyClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture

struct SendMoneyClient: DependencyKey {
    var getActiveUsers: @Sendable() async throws -> [User]
    var sendMoney: @Sendable(User, Int) async throws -> Error?
}

extension DependencyValues {
    var sendMoneyClient: SendMoneyClient {
        get { self[SendMoneyClient.self] }
        set { self[SendMoneyClient.self] = newValue }
    }
}
