//
//  LoginClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/2/23.
//

import ComposableArchitecture
import FirebaseAuth

/// Client responsible for handling user login + password reset with Firebase
struct LoginClient: DependencyKey {
    /// Takes in two strings (email + password) and attempts to login to Firebase.
    var login: @Sendable (String, String) async throws -> Error?
    /// Takes in a user email associated with an account and attempts to send a recovery email.
    var forgotPassword: @Sendable (String) async throws -> Error?
}

// Configure out `LoginClient` to be registered to TCA's dependency injection system.
extension DependencyValues {
    var loginClient: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}
