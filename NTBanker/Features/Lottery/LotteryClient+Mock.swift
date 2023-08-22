//
//  LotteryClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import ComposableArchitecture

extension LotteryClient {
    /// Mock version of `LotteryClient` that is used to power SwiftUI previews.
    static let previewValue = Self(
        retrieveLottery: {
            try await Task.sleep(for: .milliseconds(500))
            return Int.random(in: 1..<5000)
        },
        collectLottery: { _ in
            try await Task.sleep(for: .milliseconds(500))
            return nil
        }
    )
}

extension LotteryClient {
    /// Mock version of `LotteryClient` used when running tests.
    static let testValue = Self(
        retrieveLottery: unimplemented("\(Self.self).retrieveLottery"),
        collectLottery: unimplemented("\(Self.self).collectLottery")
    )
}
