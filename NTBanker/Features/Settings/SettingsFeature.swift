//
//  SettingsFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture
import OSLog

@Reducer
struct SettingsFeature {
    @ObservableState
    struct State: Equatable {
        var user: User = .placeholder
        /// State used to indicate when we show a user-facing alert
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        /// Actions an alert has available
        enum Alert: Equatable {}
        /// Actions done inside the iOS style alert
        case alert(PresentationAction<Alert>)
        case viewOnAppear
        case fetchUser
        case fetchUserResponse(TaskResult<User>)
        case signOut
        case signOutResponse(Error?)
    }
    
    @Dependency(\.settingsClient) var settingsClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert:
                return .none
                
            case .viewOnAppear:
                return .send(.fetchUser)
                
            case .fetchUser:
                return .run { send in
                    let response = await TaskResult { try await self.settingsClient.fetchUser() }
                    await send(.fetchUserResponse(response))
                }
                
            case .fetchUserResponse(.success(let user)):
                state.user = user
                return .none
                
            case .fetchUserResponse(.failure(let error)):
                Logger.settings.error("Could not fetch user: \(error.localizedDescription)")
                state.user = .placeholder
                return .none
                
            case .signOut:
                return .run { send in
                    let response = try await self.settingsClient.signOut()
                    await send(.signOutResponse(response))
                }
                
            case .signOutResponse(let error):
                if let error {
                    Logger.settings.error("Could not sign out current user: \(error.localizedDescription)")
                    state.user = .placeholder
                    state.alert = AlertState {
                        TextState("Error signing out")
                    } message: {
                        TextState(error.localizedDescription)
                    }
                    return .none
                }
                
                Logger.settings.log("Successfully signed out current user.")
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
