//
//  LoginFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/2/23.
//

import ComposableArchitecture
import Foundation

struct LoginFeature: Reducer {
    struct State: Equatable {
        @BindingState var emailQuery = ""
        @BindingState var passwordQuery = ""
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case loginButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .loginButtonTapped:
                return .none
            case .binding:
                return .none
            }
        }
    }
}
