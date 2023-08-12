//
//  LoginClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import ComposableArchitecture

extension LoginClient {
    static let previewValue = Self(
        login: { _, _ in
            try await Task.sleep(for: .milliseconds(1_100))
            return nil
        },
        forgotPassword: { _ in
            try await Task.sleep(for: .milliseconds(1_100))
            return nil
        }
    )
}

extension LoginClient {
    static let testValue = Self(
      login: unimplemented("\(Self.self).login"),
      forgotPassword: unimplemented("\(Self.self).forgotPassword")
    )
}
