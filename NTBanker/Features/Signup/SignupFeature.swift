//
//  SignupFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import Foundation

struct SignupFeature: Reducer {
    struct State: Equatable {
        @BindingState var name = ""
        @BindingState var email = ""
        @BindingState var selectedCardColor: CardColor = .blue
        @BindingState var passwordQuery = ""
        @BindingState var confirmPasswordQuery = ""
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case createButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .createButtonTapped:
                return .none
            case .binding:
                return .none
            }
        }
    }
}
