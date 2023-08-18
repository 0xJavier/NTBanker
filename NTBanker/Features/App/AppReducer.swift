//
//  AppReducer.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

struct AppReducer: Reducer {
    enum Route: Equatable {
        case empty
        case welcome
        case home
    }
    
    struct State: Equatable {
        var route: Route = .empty
        var auth = AuthenticationFeature.State()
    }
    
    enum Action {
        case onAppear
        case streamAuthStatus
        case streamAuthStatusResponse(AppReducer.Route)
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
                return .none
                
            case .onAppear:
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
