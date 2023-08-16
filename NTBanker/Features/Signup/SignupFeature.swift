//
//  SignupFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import Foundation
import OSLog

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
        @BindingState var isLoading = false
        /// Flag used to disable the login button depending if the form is filled out completely
        var shouldDisableLoginButton = true
        /// Form's credentials that will be passed to an effect
        var formCredentials: FormCredentials {
            FormCredentials(name: name, color: selectedCardColor)
        }
        /// Object used to pass user info to an effect.
        struct FormCredentials {
            /// Name of the newly created user
            let name: String
            /// Card color in the form of a string for a newly created user
            let color: CardColor
        }
    }
    
    enum Action: BindableAction {
        /// Action for when the user taps the create account button
        case createButtonTapped
        /// Action for the response from the client for creating an account
        case signupResponse(Error?)
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
                return .run { [email = state.email,
                               password = state.passwordQuery,
                               formCredentials = state.formCredentials] send in
                    let result = try await self.signupClient.signup(email, password, formCredentials)
                    await send(.signupResponse(result))
                }
                
            case .signupResponse(let error):
                state.isLoading = false
                state.shouldDisableLoginButton = false
                
                if let error {
                    Logger.signup.error("Could not create new user: \(error.localizedDescription)")
                    return .none
                }
                
                print("SUCCESS")
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
