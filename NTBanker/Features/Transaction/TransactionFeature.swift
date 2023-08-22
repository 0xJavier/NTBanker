//
//  TransactionFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture
import OSLog

struct TransactionFeature: Reducer {
    struct State: Equatable {
        /// A list of all transactions for the current user.
        var transactions = [Transaction]()
    }
    
    enum Action {
        /// Action used for the main view to start work when the view appears.
        case viewOnAppear
        /// Starts a stream from Firebase to listen to any updates for a user's transactions.
        case streamTransactions
        /// Handles the response for each update from the transaction stream. Will either receive a list of transactions or an error.
        case transactionResponse(TaskResult<[Transaction]>)
    }
    
    @Dependency(\.transactionClient) var transactionClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewOnAppear:
                return .send(.streamTransactions)
                
            case .streamTransactions:
                return .run { send in
                    for try await transactions in await self.transactionClient.streamTransactions() {
                        await send(.transactionResponse(.success(transactions)))
                    }
                } catch: { error, send in
                    await send(.transactionResponse(.failure(error)))
                }
                
            case .transactionResponse(.success(let transactions)):
                state.transactions = transactions
                return .none
                
            case .transactionResponse(.failure(let error)):
                Logger.transaction.error("Transaction stream threw an error: \(error.localizedDescription)")
                return .none
            }
        }
    }
}
