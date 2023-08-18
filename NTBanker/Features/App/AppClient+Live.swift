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
