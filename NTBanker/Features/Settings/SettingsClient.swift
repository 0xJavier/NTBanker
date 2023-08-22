//
//  SettingsClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

/// Main interface for the `SettingsClient`
struct SettingsClient: DependencyKey {
    /// Calls to firebase and attempts to get the current logged in user
    var fetchUser: @Sendable () async throws -> User
    /// Attempts to sign out the current user
    var signOut: @Sendable () async throws -> Error?
}

extension DependencyValues {
    /// Registers `SettingsClient` with TCA's dependency injection system
    var settingsClient: SettingsClient {
        get { self[SettingsClient.self] }
        set { self[SettingsClient.self] = newValue }
    }
}
