//
//  LoginFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/2/23.
//

import ComposableArchitecture
import Foundation

/// Object that holds the Login feature's state, actions, and logic in the form of a reducer.
struct LoginFeature: Reducer {
    struct State: Equatable {
        /// User email that is entered in the textfield
        @BindingState var emailQuery = ""
        /// User password that is entered in the textfield
        @BindingState var passwordQuery = ""
        /// Flag used to show a progress indicator when reaching out to Firebase
        var isLoading = false
        /// Flag used to disable the login button depending if the form is filled out completely
        var shouldDisableLoginButton = true
    }
    
    enum Action: BindableAction {
        /// Action for when a user taps the login button
        case loginButtonTapped
        /// Action for when a user wants to reset their password
        case forgotPasswordButtonTapped
        /// Action for the response from the client when logging a user in
        case loginResponse(Bool)
        /// Action for the response from the client when resetting a user's password
        case forgotPasswordResponse(Bool)
        /// Action for binding state variables with `BindingState`
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.loginClient) var loginClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .loginButtonTapped:
                state.isLoading = true
                state.shouldDisableLoginButton = true
                return .run { [email = state.emailQuery, password = state.passwordQuery] send in
                    let result = try await self.loginClient.login(email, password)
                    await send(.loginResponse(result))
                }
                
            case .forgotPasswordButtonTapped:
                return .none
                
            case .loginResponse(_):
                state.isLoading = false
                state.shouldDisableLoginButton = false
                return .none
                
            case .forgotPasswordResponse(_):
                return .none
                
            case .binding:
                state.shouldDisableLoginButton = state.emailQuery.isEmpty || state.passwordQuery.isEmpty
                return .none
            }
        }
    }
}
