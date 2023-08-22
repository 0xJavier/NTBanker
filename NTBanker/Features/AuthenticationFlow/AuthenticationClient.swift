//
//  AuthenticationClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/18/23.
//

import ComposableArchitecture

/// Main interface for the `AuthenticationClient`.
struct AuthenticationClient: DependencyKey {
    /// Attempts to log in a user with Firebase given two strings (email, password).
    var login: @Sendable (String, String) async throws -> Error?
    /// Attempts to send a password reset email to the provided email account.
    var forgotPassword: @Sendable (String) async throws -> Error?
    /// Attempts to sign up and create a new user in Firebase. Takes three inputs; string for a email, string for a password, and a
    /// `FormCredentials` object that holds information from the form the user filled out.
    var signup: @Sendable (String, String, SignupFeature.State.FormCredentials) async throws -> Error?
}

extension DependencyValues {
    /// Registers `AuthenticationClient` with TCA's dependency injection system.
    var authenticationClient: AuthenticationClient {
        get { self[AuthenticationClient.self] }
        set { self[AuthenticationClient.self] = newValue }
    }
}
