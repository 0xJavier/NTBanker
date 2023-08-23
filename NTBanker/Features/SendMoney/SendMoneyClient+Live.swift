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
import OSLog

extension SendMoneyClient {
    /// Live version of `SendMoneyClient` that reaches out to Firebase when the app is run
    static var liveValue: Self {
        let playersReference = Firestore.firestore().collection(FirebaseStringType.players.rawValue)
        
        return Self(
            getActiveUsers: {
                guard let currentUserID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let query = playersReference
                    .whereField("id", isNotEqualTo: currentUserID)
                
                do {
                    let snapshot = try await query.getDocuments()
                    return try snapshot.documents.compactMap {
                        try $0.data(as: User.self)
                    }
                } catch {
                    Logger.sendMoney.error("Error fetching / creating users: \(error.localizedDescription)")
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
                let sendingReference = playersReference
                    .document(currentUserID)
                let sendingTransactionReference = sendingReference
                    .collection(FirebaseStringType.transactions.rawValue)
                    .document()
                
                batch.updateData([
                    FirebaseStringType.balance.rawValue: FieldValue.increment(Int64(-amount))
                ], forDocument: sendingReference)
                
                try batch.setData(from: sendingTransaction, forDocument: sendingTransactionReference)
                
                // Receiving Transaction
                let receivingTransaction = Transaction(action: .receivedMoneyFromPlayer("player", amount))
                let receivingReference = playersReference
                    .document(user.id)
                let receivingTransactionReference = receivingReference
                    .collection(FirebaseStringType.transactions.rawValue)
                    .document()
                
                batch.updateData([
                    FirebaseStringType.balance.rawValue: FieldValue.increment(Int64(amount))
                ], forDocument: receivingReference)
                
                try batch.setData(from: receivingTransaction, forDocument: receivingTransactionReference)
                
                try await batch.commit()
                
                return nil
            }
        )
    }
}
