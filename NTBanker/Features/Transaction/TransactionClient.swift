//
//  TransactionClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

struct TransactionClient: DependencyKey {
    var streamTransactions: @Sendable () async -> AsyncThrowingStream<[Transaction], Error>
}

extension DependencyValues {
    var transactionClient: TransactionClient {
        get { self[TransactionClient.self] }
        set { self[TransactionClient.self] = newValue }
    }
}
