//
//  LoginFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/2/23.
//

import ComposableArchitecture
import Foundation
import OSLog

/// Reducer containing state, actions, and the main reducer for `LoginFeature`
struct LoginFeature: Reducer {
    struct State: Equatable {
        /// Binding string representing user's email
        @BindingState var emailQuery = ""
        /// Binding string representing user's password
        @BindingState var passwordQuery = ""
        /// Flag used to show a progress indicator when reaching out to Firebase
        @BindingState var isLoading = false
        /// Flag used to disable the login button depending if the form is filled out completely
        var shouldDisableLoginButton = true
        /// Flag used to indicate if the form should show fields to allow a user to reset their password
        var shouldShowForgotEmailField = false
        /// State used to indicate when we show a user-facing alert
        @PresentationState var alert: AlertState<Action.Alert>?
    }
    
    enum Action: BindableAction {
        /// Actions an alert has available
        enum Alert: Equatable {}
        /// Actions done inside the iOS style alert
        case alert(PresentationAction<Alert>)
        /// Action for when a user taps the login button
        case loginButtonTapped
        /// Action for when a user wants to reset their password
        case forgotPasswordButtonTapped
        /// Handles the response from attempting to login. If successful, `AppClient` will return the home route and show the main app tab view.
        /// Otherwise, we log and show a user facing error.
        case loginResponse(Error?)
        /// Handles the response for attempting to reset the user's password
        case forgotPasswordResponse(Error?)
        /// Action for binding state variables with `BindingState`
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.authenticationClient) var authClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .alert:
                return .none
                
            case .loginButtonTapped:
                state.isLoading = true
                state.shouldDisableLoginButton = true
                return .run { [email = state.emailQuery, password = state.passwordQuery] send in
                    let result = try await self.authClient.login(email, password)
                    await send(.loginResponse(result))
                }
                
            case .forgotPasswordButtonTapped:
                return .none
                
            case .loginResponse(let error):
                state.isLoading = false
                state.shouldDisableLoginButton = false
                if let error {
                    Logger.login.error("Could not login current user: \(error.localizedDescription)")
                    state.alert = AlertState {
                        TextState("Error signing up")
                    } message: {
                        TextState(error.localizedDescription)
                    }
                    return .none
                }
                
                Logger.login.log("Successfully logged user in.")
                return .none
                
            case .forgotPasswordResponse(_):
                return .none
                
            case .binding:
                state.shouldDisableLoginButton = state.emailQuery.isEmpty || state.passwordQuery.isEmpty
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}
