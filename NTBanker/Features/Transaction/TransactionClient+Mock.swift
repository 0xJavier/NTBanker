//
//  TransactionClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

extension TransactionClient {
    /// Mock version of `TransactionClient` that is used to power SwiftUI previews.
    static var previewValue = Self(
        streamTransactions: {
            AsyncThrowingStream { continuation in
                continuation.yield(Transaction.mockList)
            }
        }
    )
}

extension TransactionClient {
    /// Mock version of `TransactionClient` used when running tests.
    static let testValue = Self(
        streamTransactions: unimplemented("\(Self.self).streamTransactions")
    )
}
