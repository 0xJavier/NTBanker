//
//  AuthenticationClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/18/23.
//

import ComposableArchitecture

struct AuthenticationClient: DependencyKey {
    /// Takes in two strings (email + password) and attempts to login to Firebase.
    var login: @Sendable (String, String) async throws -> Error?
    /// Takes in a user email associated with an account and attempts to send a recovery email.
    var forgotPassword: @Sendable (String) async throws -> Error?
    /// Takes in a user model and attempts to create an account in Firebase.
    var signup: @Sendable (String, String, SignupFeature.State.FormCredentials) async throws -> Error?
}

extension DependencyValues {
    var authenticationClient: AuthenticationClient {
        get { self[AuthenticationClient.self] }
        set { self[AuthenticationClient.self] = newValue }
    }
}
