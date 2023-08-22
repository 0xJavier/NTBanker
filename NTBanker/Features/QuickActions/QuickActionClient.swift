//
//  QuickActionClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

/// Main interface for the `QuickActionClient`
struct QuickActionClient: DependencyKey {
    /// Action for collecting $200
    var collect200: @Sendable () async throws -> Error?
    /// User attempts to pay the bank for a game action that occured
    var payBank: @Sendable (Int) async throws -> Error?
    /// User adds to the Free Parking Lottery pile
    var payLottery: @Sendable (Int) async throws -> Error?
    /// Attempts to credit current user with a certain amount. Acts as a banker giving a player money.
    var receiveMoney: @Sendable (Int) async throws -> Error?
}

extension DependencyValues {
    /// Registers `QuickActionClient` with TCA's dependency injection system
    var quickActionClient: QuickActionClient {
        get { self[QuickActionClient.self] }
        set { self[QuickActionClient.self] = newValue }
    }
}
