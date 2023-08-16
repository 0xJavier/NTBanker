//
//  QuickActionClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

extension QuickActionClient {
    static var liveValue: Self {
        let playerRef = Firestore.firestore().collection("players")
        let lotteryRef = Firestore.firestore().collection("lottery").document("balance")
        
        return Self(
            collect200: {
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let batch = Firestore.firestore().batch()
                let transactionRef = playerRef
                    .document(userID)
                    .collection("transactions")
                    .document()
                
                batch.updateData([
                    "balance": FieldValue.increment(Int64(200))
                ], forDocument: playerRef.document(userID))
                
                let transaction = Transaction(action: .collect200)
                
                try batch.setData(from: transaction, forDocument: transactionRef)
                
                try await batch.commit()
                
                return nil
            },
            
            payBank: { amount in
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let batch = Firestore.firestore().batch()
                let transactionRef = playerRef
                    .document(userID)
                    .collection("transactions")
                    .document()
                
                batch.updateData([
                    "balance": FieldValue.increment(Int64(-amount))
                ], forDocument: playerRef.document(userID))
                
                let transaction = Transaction(action: .paidBank(-amount))
                
                try batch.setData(from: transaction, forDocument: transactionRef)
                
                try await batch.commit()
                
                return nil
            },
            
            payLottery: { amount in
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let transaction = Transaction(action: .paidLottery(-amount))
                
                let batch = Firestore.firestore().batch()
                let transactionRef = playerRef
                    .document(userID)
                    .collection("transactions")
                    .document()
                
                batch.updateData([
                    "balance": FieldValue.increment(Int64(-amount))
                ], forDocument: playerRef.document(userID))
                
                batch.updateData([
                    "amount": FieldValue.increment(Int64(amount))
                ], forDocument: lotteryRef)
                
                try batch.setData(from: transaction, forDocument: transactionRef)
                
                try await batch.commit()
                
                return nil
            },
            
            receiveMoney: { amount in
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let batch = Firestore.firestore().batch()
                let transactionRef = playerRef
                    .document(userID)
                    .collection("transactions")
                    .document()
                
                batch.updateData([
                    "balance": FieldValue.increment(Int64(amount))
                ], forDocument: playerRef.document(userID))
                
                let transaction = Transaction(action: .receivedMoneyFromBank(amount))
                
                try batch.setData(from: transaction, forDocument: transactionRef)
                
                try await batch.commit()
                
                return nil
            }
        )
    }
}
