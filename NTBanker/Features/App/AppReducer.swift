//
//  AppReducer.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

@Reducer
struct AppReducer {
    enum Route: Equatable {
        case empty
        case welcome
        case home
    }
    
    @ObservableState
    struct State: Equatable {
        var route: Route = .empty
        var auth = AuthenticationFeature.State()
    }
    
    enum Action {
        case viewOnAppear
        case streamAuthStatus
        case streamAuthStatusResponse(AppReducer.Route)
        case auth(AuthenticationFeature.Action)
    }
    
    @Dependency(\.appClient) var appClient
    
    var body: some ReducerOf<Self> {
        Scope(state: \.auth, action: \.auth) {
            AuthenticationFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .auth:
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
