//
//  HomeClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture

extension HomeClient {
    /// Mock version of `HomeClient` that is used to power SwiftUI previews.
    static let previewValue = Self(
        streamUser: {
            AsyncThrowingStream { continuation in
                continuation.yield(User.mockUserList[0])
            }
        }
    )
}

extension HomeClient {
    /// Mock version of `HomeClient` used when running tests.
    static let testValue = Self(
        streamUser: unimplemented("\(Self.self).streamUser")
    )
}
