//
//  TransactionClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

/// Main interface for the `TransactionClient`.
struct TransactionClient: DependencyKey {
    /// Async stream that listens to Firebase updates over the user's transactions.
    var streamTransactions: @Sendable () async -> AsyncThrowingStream<[Transaction], Error>
}

extension DependencyValues {
    /// Registers `TransactionClient` with TCA's dependency injection system.
    var transactionClient: TransactionClient {
        get { self[TransactionClient.self] }
        set { self[TransactionClient.self] = newValue }
    }
}
