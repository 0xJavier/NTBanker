//
//  RankingClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import ComposableArchitecture
import Firebase
import FirebaseFirestoreSwift

extension RankingClient {
    /// Live version of `RankingClient` that reaches out to Firebase when the app is run.
    static let liveValue = Self(
        fetchUsers: {
            let query = Firestore
                .firestore()
                .collection(FirebaseStringType.players.rawValue)
                .order(by: FirebaseStringType.balance.rawValue, descending: true)
            
            let snapshot = try await query.getDocuments()
            return try snapshot.documents.compactMap { try $0.data(as: User.self) }
        }
    )
}
