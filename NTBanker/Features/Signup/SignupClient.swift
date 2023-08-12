//
//  SignupClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import ComposableArchitecture

/// Client responsible for handling user/account creation with Firebase
struct SignupClient: DependencyKey {
    /// Takes in a user model and attempts to create an account in Firebase.
    var signup: @Sendable (String, String, SignupFeature.State.FormCredentials) async throws -> Error?
}

// Configure out `SignupClient` to be registered to TCA's dependency injection system.
extension DependencyValues {
    var signupClient: SignupClient {
        get { self[SignupClient.self] }
        set { self[SignupClient.self] = newValue }
    }
}
