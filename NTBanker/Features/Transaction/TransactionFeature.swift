//
//  TransactionFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture
import OSLog

@Reducer
struct TransactionFeature {
    @ObservableState
    struct State: Equatable {
        var transactions = [Transaction]()
    }
    
    enum Action {
        case viewOnAppear
        case streamTransactions
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
