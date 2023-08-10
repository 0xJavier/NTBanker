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
    static let liveValue = Self(
        fetchUsers: {
            let query = Firestore
                .firestore()
                .collection(FirebaseCollectionType.players.rawValue)
                .order(by: "balance", descending: true)
            
            let snapshot = try await query.getDocuments()
            return try snapshot.documents.compactMap { try $0.data(as: User.self) }
        }
    )
}
