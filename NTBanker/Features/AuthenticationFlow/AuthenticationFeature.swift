//
//  AuthenticationFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/18/23.
//

import ComposableArchitecture

struct AuthenticationFeature: Reducer {
    struct State: Equatable {
        var login = LoginFeature.State()
        var signup = SignupFeature.State()
    }
    
    enum Action {
        case login(LoginFeature.Action)
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
