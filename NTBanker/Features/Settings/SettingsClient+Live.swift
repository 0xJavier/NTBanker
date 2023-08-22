//
//  SettingsClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

extension SettingsClient {
    /// Live version of `SettingsClient` that reaches out to Firebase when the app is run
    static var liveValue: Self {
        return Self(
            fetchUser: {
                guard let userID = Auth.auth().currentUser?.uid else {
                    throw NTError.noUserID
                }
                
                let snapshot = try await Firestore
                    .firestore()
                    .collection(FirebaseStringType.players.rawValue)
                    .document(userID)
                    .getDocument()
                
                return try snapshot.data(as: User.self)
            },
            
            signOut: {
                try Auth.auth().signOut()
                return nil
            }
        )
    }
}
