//
//  SettingsClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

struct SettingsClient: DependencyKey {
    var fetchUser: @Sendable () async throws -> User
    var signOut: @Sendable () async throws -> Error?
}

extension DependencyValues {
    var settingsClient: SettingsClient {
        get { self[SettingsClient.self] }
        set { self[SettingsClient.self] = newValue }
    }
}
