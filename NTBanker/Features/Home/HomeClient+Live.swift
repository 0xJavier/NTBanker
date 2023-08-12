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
    static var liveValue: Self {
        let playersRef = Firestore.firestore().collection("players")
        
        return Self(
            streamUser: {
                return AsyncThrowingStream { continuation in
                    guard let userID = Auth.auth().currentUser?.uid else {
                        continuation.finish(throwing: NTError.noUserID)
                        return
                    }
                    
                    playersRef.document(userID).addSnapshotListener { documentSnapshot, error in
                        guard let document = documentSnapshot else { return }
                        
                        do {
                            let user = try document.data(as: User.self)
                            continuation.yield(user)
                        } catch {
                            print("Could not unwrap user")
                            continuation.finish(throwing: NTError.noUserID)
                        }
                    }
                }
            }
        )
    }
}
