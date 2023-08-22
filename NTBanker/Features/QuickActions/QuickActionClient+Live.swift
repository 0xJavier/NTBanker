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
    /// Live version of `QuickActionClient` that reaches out to Firebase when the app is run
    static var liveValue: Self {
        let playerReference = Firestore.firestore()
            .collection(FirebaseStringType.players.rawValue)
        
        let lotteryReference = Firestore.firestore()
            .collection(FirebaseStringType.lottery.rawValue)
            .document(FirebaseStringType.balance.rawValue)
        
        return Self(
            collect200: {
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let batch = Firestore.firestore().batch()
                let transactionReference = playerReference
                    .document(userID)
                    .collection(FirebaseStringType.transactions.rawValue)
                    .document()
                
                batch.updateData([
                    FirebaseStringType.balance.rawValue: FieldValue.increment(Int64(200))
                ], forDocument: playerReference.document(userID))
                
                let transaction = Transaction(action: .collect200)
                
                try batch.setData(from: transaction, forDocument: transactionReference)
                
                try await batch.commit()
                
                return nil
            },
            
            payBank: { amount in
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let batch = Firestore.firestore().batch()
                let transactionReference = playerReference
                    .document(userID)
                    .collection(FirebaseStringType.transactions.rawValue)
                    .document()
                
                batch.updateData([
                    FirebaseStringType.balance.rawValue: FieldValue.increment(Int64(-amount))
                ], forDocument: playerReference.document(userID))
                
                let transaction = Transaction(action: .paidBank(amount))
                
                try batch.setData(from: transaction, forDocument: transactionReference)
                
                try await batch.commit()
                
                return nil
            },
            
            payLottery: { amount in
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let transaction = Transaction(action: .paidLottery(amount))
                
                let batch = Firestore.firestore().batch()
                let transactionReference = playerReference
                    .document(userID)
                    .collection(FirebaseStringType.transactions.rawValue)
                    .document()
                
                batch.updateData([
                    FirebaseStringType.balance.rawValue: FieldValue.increment(Int64(-amount))
                ], forDocument: playerReference.document(userID))
                
                batch.updateData([
                    FirebaseStringType.amount.rawValue: FieldValue.increment(Int64(amount))
                ], forDocument: lotteryReference)
                
                try batch.setData(from: transaction, forDocument: transactionReference)
                
                try await batch.commit()
                
                return nil
            },
            
            receiveMoney: { amount in
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let batch = Firestore.firestore().batch()
                let transactionReference = playerReference
                    .document(userID)
                    .collection(FirebaseStringType.transactions.rawValue)
                    .document()
                
                batch.updateData([
                    FirebaseStringType.balance.rawValue: FieldValue.increment(Int64(amount))
                ], forDocument: playerReference.document(userID))
                
                let transaction = Transaction(action: .receivedMoneyFromBank(amount))
                
                try batch.setData(from: transaction, forDocument: transactionReference)
                
                try await batch.commit()
                
                return nil
            }
        )
    }
}
