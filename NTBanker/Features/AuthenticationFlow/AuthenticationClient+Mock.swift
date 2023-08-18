//
//  AuthenticationClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/18/23.
//

import ComposableArchitecture
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

extension AuthenticationClient {
    static var previewValue: Self {
        return Self(
            login: { email, password in
                try await Task.sleep(for: .milliseconds(1_100))
                return nil
            },
            
            forgotPassword: { email in
                try await Task.sleep(for: .milliseconds(1_100))
                return nil
            },
            
            signup: { email, password, formCredentials in
                try await Task.sleep(for: .milliseconds(1_100))
                return nil
            }
        )
    }
}

extension AuthenticationClient {
    static let testValue = Self(
        login: unimplemented("\(Self.self).login"),
        forgotPassword: unimplemented("\(Self.self).forgotPassword"),
        signup: unimplemented("\(Self.self).signup")
    )
}
