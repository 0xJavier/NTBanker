//
//  QuickActionClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture


struct QuickActionClient: DependencyKey {
    var collect200: @Sendable () async throws -> Error?
    var payBank: @Sendable (Int) async throws -> Error?
    var payLottery: @Sendable (Int) async throws -> Error?
    var receiveMoney: @Sendable (Int) async throws -> Error?
}

extension DependencyValues {
    var quickActionClient: QuickActionClient {
        get { self[QuickActionClient.self] }
        set { self[QuickActionClient.self] = newValue }
    }
}
