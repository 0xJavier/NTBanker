//
//  AuthenticationFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/18/23.
//

import ComposableArchitecture

@Reducer
struct AuthenticationFeature {
    @ObservableState
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
        Scope(state: \.login, action: \.login) {
            LoginFeature()
        }
        
        Scope(state: \.signup, action: \.signup) {
            SignupFeature()
        }
    }
}
