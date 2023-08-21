//
//  LoginFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/2/23.
//

import ComposableArchitecture
import Foundation
import OSLog

/// Object that holds the Login feature's state, actions, and logic in the form of a reducer.
struct LoginFeature: Reducer {
    struct State: Equatable {
        /// User email that is entered in the textfield
        @BindingState var emailQuery = ""
        /// User password that is entered in the textfield
        @BindingState var passwordQuery = ""
        /// Flag used to show a progress indicator when reaching out to Firebase
        @BindingState var isLoading = false
        /// Flag used to disable the login button depending if the form is filled out completely
        var shouldDisableLoginButton = true
        ///
        var shouldShowForgotEmailField = false
    }
    
    enum Action: BindableAction {
        /// Action for when a user taps the login button
        case loginButtonTapped
        /// Action for when a user wants to reset their password
        case forgotPasswordButtonTapped
        /// Action for the response from the client when logging a user in
        case loginResponse(Error?)
        /// Action for the response from the client when resetting a user's password
        case forgotPasswordResponse(Error?)
        /// Action for binding state variables with `BindingState`
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.authenticationClient)
    var authClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .loginButtonTapped:
                state.isLoading = true
                state.shouldDisableLoginButton = true
                return .run { [email = state.emailQuery, password = state.passwordQuery] send in
                    let result = try await self.authClient.login(email, password)
                    await send(.loginResponse(result))
                }
                
            case .forgotPasswordButtonTapped:
                //TODO: Present Alert with textfield to reset password
                return .none
                
            case .loginResponse(let error):
                state.isLoading = false
                state.shouldDisableLoginButton = false
                if let error {
                    Logger.login.error("Could not login current user: \(error.localizedDescription)")
                    return .none
                }
                
                print("SUCESS")
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
