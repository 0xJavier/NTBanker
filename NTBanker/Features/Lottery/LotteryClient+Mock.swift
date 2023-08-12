//
//  LotteryClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import ComposableArchitecture

extension LotteryClient {
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
    static let testValue = Self(
        retrieveLottery: unimplemented("\(Self.self).retrieveLottery"),
        collectLottery: unimplemented("\(Self.self).collectLottery")
    )
}
