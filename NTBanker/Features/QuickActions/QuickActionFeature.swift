//
//  QuickActionFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

struct QuickActionFeature: Reducer {
    struct State: Equatable {
        var quickActions = QuickActionType.actionList
    }
    
    enum Action {
        case actionButtonTapped(QuickActionType)
        case collect200
        case collect200Response(Error?)
        case payBank(Int)
        case payBankResponse(Error?)
    }
    
    @Dependency(\.quickActionClient) var quickActionClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .actionButtonTapped(let action):
                switch action {
                case .sendMoney:
                    print("Send Money Tapped")
                    return .none
                    
                case .collect200:
                    return .run { send in
                        await send(.collect200)
                    }
                    
                case .payBank:
                    return .run { send in
                        await send(.payBank(200))
                    }
                    
                case .payLottery:
                    print("Pay Lottery Tapped")
                    return .none
                    
                case .receiveMoney:
                    print("Receive Money Tapped")
                    return .none
                }
                
            case .collect200:
                return .run { send in
                    let response = try await self.quickActionClient.collect200()
                    await send(.collect200Response(response))
                }
                
            case .collect200Response(let error):
                if let error {
                    print("ERROR: \(error.localizedDescription)")
                    return .none
                }
                
                print("SUCCESS")
                return .none
                
            case .payBank(let amount):
                return .run { send in
                    let response = try await self.quickActionClient.payBank(amount)
                    await send(.payBankResponse(response))
                }
                
            case .payBankResponse(let error):
                if let error {
                    print("ERROR: \(error.localizedDescription)")
                    return .none
                }
                
                print("SUCCESS")
                return .none
            }
        }
    }
}
