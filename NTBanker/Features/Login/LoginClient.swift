//
//  LoginClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/2/23.
//

import ComposableArchitecture

/// Client responsible for handling user login + password reset with Firebase
struct LoginClient: DependencyKey {
    /// Takes in two strings (email + password) and attempts to login to Firebase.
    var login: @Sendable (String, String) async throws -> Bool
    /// Takes in a user email associated with an account and attempts to send a recovery email.
    var forgotPassword: @Sendable (String) async throws -> Bool
}

// Live version of `LoginClient` that will reach out to Firebase when running the app.
extension LoginClient {
    static let liveValue = Self(
        login: { email, password in
            return true
        },
        forgotPassword: { email in
            return true
        }
    )
}

// Client version to be used when using SwiftUI's previews. Will not reach out to Firebase.
extension LoginClient {
    static let previewValue = Self(
        login: { email, password in
            try await Task.sleep(for: .milliseconds(1_100))
            return true
        },
        forgotPassword: { email in
            try await Task.sleep(for: .milliseconds(1_100))
            return true
        }
    )
}

// Mock version of `LoginClient` to be used when testing. Should be created in tests with mock responses.
extension LoginClient {
    static let testValue = Self(
      login: unimplemented("\(Self.self).login"),
      forgotPassword: unimplemented("\(Self.self).forgotPassword")
    )
}

// Configure out `LoginClient` to be registered to TCA's dependency injection system.
extension DependencyValues {
    var loginClient: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}
