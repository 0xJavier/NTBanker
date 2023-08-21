//
//  SettingsFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture

struct SettingsFeature: Reducer {
    struct State: Equatable {
        var user: User = .placeholder
    }
    
    enum Action {
        case fetchUser
        case fetchUserResponse(TaskResult<User>)
        case signOut
        case signOutResponse(Error?)
    }
    
    @Dependency(\.settingsClient)
    var settingsClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchUser:
                return .run { send in
                    let response = await TaskResult { try await self.settingsClient.fetchUser() }
                    await send(.fetchUserResponse(response))
                }
                
            case .fetchUserResponse(.success(let user)):
                state.user = user
                return .none
                
            case .fetchUserResponse(.failure(let error)):
                print("ERROR: \(error.localizedDescription)")
                return .none
                
            case .signOut:
                return .run { send in
                    let response = try await self.settingsClient.signOut()
                    await send(.signOutResponse(response))
                }
                
            case .signOutResponse(let error):
                guard let error else {
                    return .none
                }
                
                print("ERROR: \(error.localizedDescription)")
                return .none
            }
        }
    }
}
