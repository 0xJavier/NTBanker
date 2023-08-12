//
//  LotteryClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture

struct LotteryClient: DependencyKey {
    var retrieveLottery: @Sendable () async throws -> Int
    var collectLottery: @Sendable (Int) async throws -> Error?
}

extension DependencyValues {
    var lotteryClient: LotteryClient {
        get { self[LotteryClient.self] }
        set { self[LotteryClient.self] = newValue }
    }
}
