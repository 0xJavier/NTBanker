//
//  SignupFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import Foundation

/// Object that holds the Signup feature's state, actions, and logic in the form of a reducer.
struct SignupFeature: Reducer {
    struct State: Equatable {
        /// Query used to represent user's name
        @BindingState var name = ""
        /// Query used to represent user's email
        @BindingState var email = ""
        /// Holds the user's selected card color from a form
        @BindingState var selectedCardColor: CardColor = .blue
        /// Query used to represent user's  password input
        @BindingState var passwordQuery = ""
        /// Query used to represent user's confirm password
        @BindingState var confirmPasswordQuery = ""
        /// Flag used to show a progress indicator when reaching out to Firebase
        var isLoading = false
        /// Flag used to disable the login button depending if the form is filled out completely
        var shouldDisableLoginButton = true
    }
    
    enum Action: BindableAction {
        /// Action for when the user taps the create account button
        case createButtonTapped
        /// Action for the response from the client for creating an account
        case signupResponse(Bool)
        /// Action for binding state variables with `BindingState`
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.signupClient) var signupClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .createButtonTapped:
                state.isLoading = true
                state.shouldDisableLoginButton = true
                let user = User(userID: "123", name: state.name, email: state.email,
                                balance: 1500, color: state.selectedCardColor.rawValue)
                return .run { send in
                    let result = try await self.signupClient.signup(user)
                    await send(.signupResponse(result))
                }
                
            case .signupResponse(_):
                state.isLoading = false
                state.shouldDisableLoginButton = false
                return .none
                
            case .binding:
                state.shouldDisableLoginButton = state.name.isEmpty
                || state.email.isEmpty
                || state.passwordQuery.isEmpty
                || state.confirmPasswordQuery.isEmpty
                return .none
            }
        }
    }
}
