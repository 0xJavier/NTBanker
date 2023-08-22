//
//  AuthenticationClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/18/23.
//

import ComposableArchitecture
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

extension AuthenticationClient {
    /// Live version of `AuthenticationClient` that reaches out to Firebase when the app is run.
    static var liveValue: Self {
        return Self(
            login: { email, password in
                try await Auth.auth().signIn(withEmail: email, password: password)
                return nil
            },
            
            forgotPassword: { email in
                try await Auth.auth().sendPasswordReset(withEmail: email)
                return nil
            },
            
            signup: { email, password, formCredentials in
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                let newUser = User(id: authResult.user.uid, name: formCredentials.name,
                                   balance: 1500, color: formCredentials.color)
                try Firestore
                    .firestore()
                    .collection(FirebaseStringType.players.rawValue)
                    .document(authResult.user.uid)
                    .setData(from: newUser)
                return nil
            }
        )
    }
}
