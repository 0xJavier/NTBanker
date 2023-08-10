//
//  HomeClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture

extension HomeClient {
    static let previewValue = Self(
        streamUser: {
            AsyncThrowingStream { continuation in
                continuation.yield(User.placeholder)
            }
        }
    )
}

extension HomeClient {
    static let testValue = Self(
        streamUser: unimplemented("\(Self.self).streamUser")
    )
}
