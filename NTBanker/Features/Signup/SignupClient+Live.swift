//
//  SignupClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/9/23.
//

import ComposableArchitecture
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

extension SignupClient {
    static let liveValue = Self(
        signup: { email, password, formCredentials in
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                let newUser = User(userID: authResult.user.uid, name: formCredentials.name,
                                   email: email, color: formCredentials.color)
                try Firestore
                    .firestore()
                    .collection(FirebaseCollectionType.players.rawValue)
                    .document(authResult.user.uid)
                    .setData(from: newUser)
                return nil
            } catch {
                return error
            }
        }
    )
}
