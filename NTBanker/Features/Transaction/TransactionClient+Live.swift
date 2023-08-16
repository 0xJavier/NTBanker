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
    static var liveValue: Self {
        let playersRef = Firestore.firestore().collection("players")
        
        return Self(
            streamTransactions: {
                return AsyncThrowingStream { continuation in
                    guard let userID = Auth.auth().currentUser?.uid else {
                        continuation.finish(throwing: NTError.noUserID)
                        return
                    }
                    
                    playersRef.document(userID).collection("transactions")
                        .order(by: "createdAt", descending: true)
                        .addSnapshotListener { querySnapshot, error in
                            guard let documents = querySnapshot?.documents else {
                                print("Could not get documents")
                                continuation.finish(throwing: NTError.noUserID)
                                return
                            }
                            
                            let transactions = documents.compactMap {
                                try? $0.data(as: NewTransaction.self)
                            }
                            
                            continuation.yield(transactions)
                        }
                }
            }
        )
    }
}
