//
//  SignupClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/9/23.
//

import ComposableArchitecture

// Client version to be used when using SwiftUI's previews. Will not reach out to Firebase.
extension SignupClient {
    static let previewValue = Self(
        signup: { _,_,_  in
            try await Task.sleep(for: .milliseconds(1_100))
            return nil
        }
    )
}

// Mock version of `SignupClient` to be used when testing. Should be created in XCTests with mock responses.
extension SignupClient {
    static let testValue = Self(
        signup: unimplemented("\(Self.self).signup")
    )
}
