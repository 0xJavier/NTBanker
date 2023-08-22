//
//  AuthenticationFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/18/23.
//

import ComposableArchitecture

/// Reducer containing state, actions, and the main reducer for `AuthenticationFeature`.
struct AuthenticationFeature: Reducer {
    struct State: Equatable {
        /// State for the `LoginFeature`
        var login = LoginFeature.State()
        /// State for the `SignupFeature`
        var signup = SignupFeature.State()
    }
    
    enum Action {
        /// Actions associated with the `LoginFeature`
        case login(LoginFeature.Action)
        /// Actions associated with the `SignupFeature`
        case signup(SignupFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.login, action: /Action.login) {
            LoginFeature()
        }
        
        Scope(state: \.signup, action: /Action.signup) {
            SignupFeature()
        }
    }
}
