//
//  HomeClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

extension HomeClient {
    /// Live version of `HomeClient` that reaches out to Firebase when the app is run.
    static var liveValue: Self {
        let playersReference = Firestore.firestore().collection(FirebaseStringType.players.rawValue)
        
        return Self(
            streamUser: {
                return AsyncThrowingStream { continuation in
                    guard let userID = Auth.auth().currentUser?.uid else {
                        continuation.finish(throwing: NTError.noUserID)
                        return
                    }
                    
                    playersReference
                        .document(userID)
                        .addSnapshotListener { documentSnapshot, error in
                            guard let document = documentSnapshot else {
                                continuation.finish(throwing: NTError.documentError)
                                return
                            }

                            do {
                                let user = try document.data(as: User.self)
                                continuation.yield(user)
                            } catch {
                                continuation.finish(throwing: NTError.userDecodeError)
                            }
                        }
                }
            }
        )
    }
}
