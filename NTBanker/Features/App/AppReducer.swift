//
//  AppReducer.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

/// Main app reducer which handles presenting the correct views based on the auth status of the current user
struct AppReducer: Reducer {
    
    /// Type that represents the current route for the app
    enum Route: Equatable {
        /// initial route while we validate the user's session. Can be replaced with a loading view
        case empty
        /// Welcome flow used to either sign in or log in a user
        case welcome
        /// Main app flow consisting of the main app tab view with associated features
        case home
    }
    
    struct State: Equatable {
        /// Current route for the app. Main states are either the welcome or the home screen based on if the user is currently signed in
        var route: Route = .empty
        /// State for the `AuthenticationFeature` flow which consists of login and signup views / features
        var auth = AuthenticationFeature.State()
    }
    
    enum Action {
        /// Action used for the main view to start work when the view appears.
        case viewOnAppear
        /// Starts a stream from Firebase to listen to any updates to the user's auth status
        case streamAuthStatus
        /// Handles the response from the auth stream. The client will return a route that will either show the welcome or the home screen based
        /// on if the user is currently signed in
        case streamAuthStatusResponse(AppReducer.Route)
        /// Handles actions for the `AuthenticationFeature`
        case auth(AuthenticationFeature.Action)
    }
    
    @Dependency(\.appClient) var appClient
    
    var body: some ReducerOf<Self> {
        Scope(state: \.auth, action: /Action.auth) {
            AuthenticationFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .auth:
                // Should be handled in the scoped domain.
                return .none
                
            case .viewOnAppear:
                return .send(.streamAuthStatus)
                
            case .streamAuthStatus:
                return .run { send in
                    for await route in await self.appClient.streamAuthStatus() {
                        await send(.streamAuthStatusResponse(route))
                    }
                }
            
            case .streamAuthStatusResponse(let route):
                state.route = route
                return .none
            }
        }
    }
}
