//
//  HomeClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture

/// Main interface for the `HomeClient`.
struct HomeClient: DependencyKey {
    /// Async stream that listens to Firebase updates related to the currently signed in user.
    var streamUser: @Sendable () async -> AsyncThrowingStream<User, Error>
    
}

extension DependencyValues {
    /// Registers `HomeClient` with TCA's dependency injection system.
    var homeClient: HomeClient {
        get { self[HomeClient.self] }
        set { self[HomeClient.self] = newValue }
    }
}
