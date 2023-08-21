//
//  SettingsClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

extension SettingsClient {
    static var previewValue = Self(
        fetchUser: {
            try await Task.sleep(for: .milliseconds(500))
            return User.mockUserList[0]
        },
        
        signOut: {
            try await Task.sleep(for: .milliseconds(500))
            return nil
        }
    )
}

extension SettingsClient {
    static let testValue = Self(
        fetchUser: unimplemented("\(Self.self).fetchUser"),
        signOut: unimplemented("\(Self.self).signOut")
    )
}
