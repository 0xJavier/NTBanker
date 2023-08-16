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
    static let liveValue = Self(
        retrieveLottery: {
            let lotteryRef = Firestore
                .firestore()
                .collection(FirebaseCollectionType.lottery.rawValue)
                .document("balance")
            
            let document = try await lotteryRef.getDocument()
            guard let amount = document.data()?["amount"] as? Int else {
                Logger.lottery.error("Could not unwrap amount from document.")
                return 0
            }
            return amount
        },
        
        collectLottery: { amount in
            guard let currentUserID = Auth.auth().currentUser?.uid else {
                return NTError.noUserID
            }
            
            let db = Firestore.firestore()
            let batch  = db.batch()
            
            let transactionRef = db
                .collection("players")
                .document(currentUserID)
                .collection("transactions")
                .document()
            
            let lotteryRef = db
                .collection("lottery")
                .document("balance")
            
            let transaction = Transaction(action: .wonLottery(amount))
            
            batch.updateData([
                "balance": FieldValue.increment(Int64(amount))
            ], forDocument: Firestore.firestore().collection("players").document(currentUserID))

            try batch.setData(from: transaction, forDocument: transactionRef)

            batch.updateData([
                "amount": 0
            ], forDocument: lotteryRef)
            
            try await batch.commit()
            
            return nil
        }
    )
}
