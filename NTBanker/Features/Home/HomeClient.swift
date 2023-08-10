//
//  HomeClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture

/// Client responsible for handling user/account creation with Firebase
struct HomeClient: DependencyKey {
    var streamUser: @Sendable () async -> AsyncThrowingStream<User, Error>
    
}

// Configure out `SignupClient` to be registered to TCA's dependency injection system.
extension DependencyValues {
    var homeClient: HomeClient {
        get { self[HomeClient.self] }
        set { self[HomeClient.self] = newValue }
    }
}
