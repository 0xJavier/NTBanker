//
//  SendMoneyClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture

/// Main interface for the `SendMoneyClient`
struct SendMoneyClient: DependencyKey {
    /// Calls to firebase and retrieves all current active users. Will remove the currently logged in user from the list.
    var getActiveUsers: @Sendable() async throws -> [User]
    /// Attempts to send money to another player in Firebase. Takes in a user object for the player the current user wants to send money to
    /// and a integer representing the dollar amount to send.
    var sendMoney: @Sendable(User, Int) async throws -> Error?
}

extension DependencyValues {
    /// Registers `SendMoneyClient` with TCA's dependency injection system
    var sendMoneyClient: SendMoneyClient {
        get { self[SendMoneyClient.self] }
        set { self[SendMoneyClient.self] = newValue }
    }
}
