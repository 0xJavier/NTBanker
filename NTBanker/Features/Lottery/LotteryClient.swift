//
//  LotteryClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture

/// Client responsible for handling user/account creation with Firebase
struct LotteryClient: DependencyKey {
    ///
    var retrieveLottery: @Sendable () async throws -> Int
    ///
    var collectLottery: @Sendable () async throws -> Bool
}

// Live version of `LotteryClient` that will reach out to Firebase when running the app.
extension LotteryClient {
    static let liveValue = Self(
        retrieveLottery: {
            return Int.random(in: 1..<5000)
        },
        collectLottery: {
            return true
        }
    )
}

// Client version to be used when using SwiftUI's previews. Will not reach out to Firebase.
extension LotteryClient {
    static let previewValue = Self(
        retrieveLottery: {
            try await Task.sleep(for: .milliseconds(1_100))
            return Int.random(in: 1..<5000)
        },
        collectLottery: {
            return true
        }
    )
}

// Mock version of `SignupClient` to be used when testing. Should be created in XCTests with mock responses.
extension LotteryClient {
    static let testValue = Self(
        retrieveLottery: unimplemented("\(Self.self).retrieveLottery"),
        collectLottery: unimplemented("\(Self.self).collectLottery")
    )
}

// Configure out `SignupClient` to be registered to TCA's dependency injection system.
extension DependencyValues {
    var lotteryClient: LotteryClient {
        get { self[LotteryClient.self] }
        set { self[LotteryClient.self] = newValue }
    }
}
