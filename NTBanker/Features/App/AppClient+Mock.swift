//
//  AppClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

extension AppClient {
    static var previewValue = Self(
        streamAuthStatus: {
            AsyncStream { continuation in
                continuation.yield(.welcome)
            }
        }
    )
}

extension AppClient {
    static let testValue = Self(
        streamAuthStatus: unimplemented("\(Self.self).streamAuthStatus")
    )
}
