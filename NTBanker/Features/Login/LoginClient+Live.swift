//
//  LoginClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture
import FirebaseAuth

extension LoginClient {
    static let liveValue = Self(
        login: { email, password in
            do {
                try await Auth.auth().signIn(withEmail: email, password: password)
                return nil
            } catch {
                return error
            }
        },
        forgotPassword: { email in
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
                return nil
            } catch {
                return error
            }
        }
    )
}
