//
//  SendMoneyClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

extension SendMoneyClient {
    static var liveValue: Self {
        let playersRef = Firestore.firestore().collection("players")
        
        return Self(
            getActiveUsers: {
                guard let currentUserID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let query = playersRef
                    .whereField("userID", isNotEqualTo: currentUserID)
                
                do {
                    let snapshot = try await query.getDocuments()
                    return try snapshot.documents.compactMap {
                        try $0.data(as: User.self)
                    }
                } catch {
                    print("Error fetching users: \(error)")
                    return []
                }
            },
            
            sendMoney: { user, amount in
                guard let currentUserID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
  
                let batch = Firestore.firestore().batch()
                
                //Sending Transaction
                let sendingTransaction = Transaction(action: .paidPlayer(user.name, amount))
                let sendingRef = Firestore.firestore().collection("players").document(currentUserID)
                let sendingTransactionRef = sendingRef.collection("transactions").document()
                
                batch.updateData([
                    "balance": FieldValue.increment(Int64(-amount))
                ], forDocument: sendingRef)
                
                try batch.setData(from: sendingTransaction, forDocument: sendingTransactionRef)
                
                // Receiving Transaction
                // TODO: Add sending player's name
                let receivingTransaction = Transaction(action: .receivedMoneyFromPlayer("player", amount))
                let receivingRef = Firestore.firestore().collection("players").document(user.userID)
                let receivingTransactionRef = receivingRef.collection("transactions").document()
                
                batch.updateData([
                    "balance": FieldValue.increment(Int64(amount))
                ], forDocument: receivingRef)
                
                try batch.setData(from: receivingTransaction, forDocument: receivingTransactionRef)
                
                try await batch.commit()
                
                return nil
            }
        )
    }
}
