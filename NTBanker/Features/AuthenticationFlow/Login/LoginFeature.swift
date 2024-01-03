//
//  LoginFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/2/23.
//

import ComposableArchitecture
import OSLog

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
        var emailQuery = ""
        var passwordQuery = ""
        var isLoading = false
        var shouldDisableLoginButton = true
        var shouldShowForgotEmailField = false
        /// State used to indicate when we show a user-facing alert
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action: BindableAction {
        /// Actions an alert has available
        enum Alert: Equatable {}
        /// Actions done inside the iOS style alert
        case alert(PresentationAction<Alert>)
        case loginButtonTapped
        case forgotPasswordButtonTapped
        case loginResponse(Error?)
        case forgotPasswordResponse(Error?)
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
        .ifLet(\.$alert, action: \.alert)
    }
}
