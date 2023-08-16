//
//  TransactionFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

struct TransactionFeature: Reducer {
    struct State: Equatable {
        var transactions = [NewTransaction]()
    }
    
    enum Action {
        case streamTransactions
        case transactionResponse(TaskResult<[NewTransaction]>)
    }
    
    @Dependency(\.transactionClient) var transactionClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
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
                print("ERROR: \(error.localizedDescription)")
                return .none
            }
        }
    }
}
