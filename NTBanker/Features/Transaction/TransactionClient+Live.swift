//
//  TransactionClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

extension TransactionClient {
    /// Live version of `TransactionClient` that reaches out to Firebase when the app is run.
    static var liveValue: Self {
        let playersReference = Firestore.firestore().collection(FirebaseStringType.players.rawValue)
        
        return Self(
            streamTransactions: {
                return AsyncThrowingStream { continuation in
                    guard let userID = Auth.auth().currentUser?.uid else {
                        continuation.finish(throwing: NTError.noUserID)
                        return
                    }
                    
                    playersReference
                        .document(userID)
                        .collection(FirebaseStringType.transactions.rawValue)
                        .order(by: "createdAt", descending: true)
                        .addSnapshotListener { querySnapshot, error in
                            guard let documents = querySnapshot?.documents else {
                                continuation.finish(throwing: NTError.documentError)
                                return
                            }
                            
                            let transactions = documents.compactMap {
                                try? $0.data(as: Transaction.self)
                            }
                            
                            continuation.yield(transactions)
                        }
                }
            }
        )
    }
}
