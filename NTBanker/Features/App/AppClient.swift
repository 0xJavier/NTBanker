//
//  AppClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

/// Main interface for the `AppClient`
struct AppClient: DependencyKey {
    /// Async stream that listens to the auth status of the user. Will return a route depending if we are logged in or not
    var streamAuthStatus: @Sendable () async -> AsyncStream<AppReducer.Route>
}

extension DependencyValues {
    /// Registers `AppClient` with TCA's dependency injection system
    var appClient: AppClient {
        get { self[AppClient.self] }
        set { self[AppClient.self] = newValue }
    }
}
