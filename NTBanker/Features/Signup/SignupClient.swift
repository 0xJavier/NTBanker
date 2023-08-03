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
    var signup: @Sendable (User) async throws -> Bool
}

// Live version of `SignupClient` that will reach out to Firebase when running the app.
extension SignupClient {
    // TODO: Replace with Firebase
    static let liveValue = Self(
        signup: { _ in
            return true
        }
    )
}

// Client version to be used when using SwiftUI's previews. Will not reach out to Firebase.
extension SignupClient {
    static let previewValue = Self(
        signup: { _ in
            try await Task.sleep(for: .milliseconds(1_100))
            return true
        }
    )
}

// Mock version of `SignupClient` to be used when testing. Should be created in XCTests with mock responses.
extension SignupClient {
    static let testValue = Self(
      signup: unimplemented("\(Self.self).signup")
    )
}

// Configure out `SignupClient` to be registered to TCA's dependency injection system.
extension DependencyValues {
    var signupClient: SignupClient {
        get { self[SignupClient.self] }
        set { self[SignupClient.self] = newValue }
    }
}

