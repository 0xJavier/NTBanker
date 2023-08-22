//
//  AppClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture
import FirebaseAuth
import SwiftUI

extension AppClient {
    /// Live version of `AppClient` that reaches out to Firebase when the app is run
    static var liveValue: Self {
        return Self(
            streamAuthStatus: {
                return AsyncStream { continuation in
                    Auth.auth().addStateDidChangeListener { _, user in
                        continuation.yield(user == nil ? .welcome : .home)
                    }
                }
            }
        )
    }
}
