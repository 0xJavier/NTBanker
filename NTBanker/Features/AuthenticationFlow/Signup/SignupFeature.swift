//
//  SignupFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import OSLog

@Reducer
struct SignupFeature {
    @ObservableState
    struct State: Equatable {
        var name = ""
        var email = ""
        var selectedCardColor: CardColor = .blue
        var passwordQuery = ""
        var confirmPasswordQuery = ""
        var isLoading = false
        var shouldDisableLoginButton = true
        /// State used to indicate when we show a user-facing alert
        @Presents var alert: AlertState<Action.Alert>?
        /// Form's current credentials that will be passed to an effect
        var formCredentials: FormCredentials {
            FormCredentials(name: name, color: selectedCardColor)
        }
        /// Object used to pass form fields to an effect
        struct FormCredentials {
            let name: String
            let color: CardColor
        }
    }
    
    enum Action: BindableAction {
        /// Actions an alert has available
        enum Alert: Equatable {}
        /// Actions done inside the iOS style alert
        case alert(PresentationAction<Alert>)
        case createButtonTapped
        case signupResponse(Error?)
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
                
            case .createButtonTapped:
                state.isLoading = true
                state.shouldDisableLoginButton = true
                return .run { [email = state.email,
                               password = state.passwordQuery,
                               formCredentials = state.formCredentials] send in
                    let result = try await self.authClient.signup(email, password, formCredentials)
                    await send(.signupResponse(result))
                } catch: { error, send in
                    await send(.signupResponse(error))
                }
                
            case .signupResponse(let error):
                state.isLoading = false
                state.shouldDisableLoginButton = false
                
                if let error {
                    Logger.signup.error("Could not create new user: \(error.localizedDescription)")
                    state.alert = AlertState {
                        TextState("Error signing up")
                    } message: {
                        TextState(error.localizedDescription)
                    }
                    return .none
                }
                
                Logger.signup.log("Successfully created / signed up new user.")
                return .none
                
            case .binding:
                state.shouldDisableLoginButton = state.name.isEmpty
                || state.email.isEmpty
                || state.passwordQuery.isEmpty
                || state.confirmPasswordQuery.isEmpty
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
