//
//  AppClient.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

struct AppClient: DependencyKey {
    var streamAuthStatus: @Sendable () async -> AsyncStream<AppReducer.Route>
}

extension DependencyValues {
    var appClient: AppClient {
        get { self[AppClient.self] }
        set { self[AppClient.self] = newValue }
    }
}
