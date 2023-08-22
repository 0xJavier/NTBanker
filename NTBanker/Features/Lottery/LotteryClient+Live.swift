//
//  LotteryClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import ComposableArchitecture
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import OSLog

extension LotteryClient {
    /// Live version of `LotteryClient` that reaches out to Firebase when the app is run.
    static var liveValue: Self {
        let database = Firestore.firestore()
        
        let userCollection = database
            .collection(FirebaseStringType.players.rawValue)
        
        let lotteryReference = database
            .collection(FirebaseStringType.lottery.rawValue)
            .document(FirebaseStringType.balance.rawValue)
        
        return Self (
            retrieveLottery: {
                let document = try await lotteryReference.getDocument()
                guard let amount = document.data()?[FirebaseStringType.amount.rawValue] as? Int else {
                    Logger.lottery.error("Could not unwrap amount from document.")
                    return 0
                }
                return amount
            },
            
            collectLottery: { amount in
                guard let currentUserID = Auth.auth().currentUser?.uid else {
                    return NTError.noUserID
                }
                
                let batch  = database.batch()
                
                let userTransactionReference = userCollection
                    .document(currentUserID)
                    .collection(FirebaseStringType.transactions.rawValue)
                    .document()
                
                let transaction = Transaction(action: .wonLottery(amount))
                
                batch.updateData([
                    FirebaseStringType.balance.rawValue: FieldValue.increment(Int64(amount))
                ], forDocument: userCollection.document(currentUserID))
                
                try batch.setData(from: transaction, forDocument: userTransactionReference)
                
                batch.updateData([
                    FirebaseStringType.amount.rawValue: 0
                ], forDocument: lotteryReference)
                
                try await batch.commit()
                
                return nil
            }
        )
    }
}
