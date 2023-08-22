//
//  AppClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

extension AppClient {
    /// Mock version of `AppClient` that is used to power SwiftUI previews
    static var previewValue = Self(
        streamAuthStatus: {
            AsyncStream { continuation in
                continuation.yield(.welcome)
            }
        }
    )
}

extension AppClient {
    /// Mock version of `AppClient` used when running tests
    static let testValue = Self(
        streamAuthStatus: unimplemented("\(Self.self).streamAuthStatus")
    )
}
