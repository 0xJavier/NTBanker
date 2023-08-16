//
//  TransactionClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

extension TransactionClient {
    static var previewValue = Self(
        streamTransactions: {
            AsyncThrowingStream { continuation in
                continuation.yield(Transaction.mockList)
            }
        }
    )
}

extension TransactionClient {
    static let testValue = Self(
        streamTransactions: unimplemented("\(Self.self).streamTransactions")
    )
}
