//
//  LotteryClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture

/// Main interface for the `LotteryClient`.
struct LotteryClient: DependencyKey {
    /// Calls to Firebase to retrieve the current lottery amount.
    var retrieveLottery: @Sendable () async throws -> Int
    /// Takes an Integer input representing lottery amount and attempts to collect it for the current user.
    /// This call will throw an error if unsuccessful.
    var collectLottery: @Sendable (Int) async throws -> Error?
}

extension DependencyValues {
    /// Registers `LotteryClient` with TCA's dependency injection system.
    var lotteryClient: LotteryClient {
        get { self[LotteryClient.self] }
        set { self[LotteryClient.self] = newValue }
    }
}
