//
//  HomeFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture

struct HomeFeature: Reducer {
    struct State: Equatable {
        var user = User.placeholder
        var quickActions = QuickActionType.actionList
        var transactions = Transaction.mockList
    }
    
    enum Action {
        case streamUser
        case streamTransactions
        case actionButtonTapped(QuickActionType)
    }
    
    @Dependency(\.homeClient) var homeClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .streamUser:
                return .none
                
            case .streamTransactions:
                return .none
                
            case .actionButtonTapped(let action):
                switch action {
                case .sendMoney:
                    print("Send Money Tapped")
                    return .none
                    
                case .collect200:
                    print("Collect 200 Tapped")
                    return .none
                    
                case .payBank:
                    print("Pay Bank Tapped")
                    return .none
                    
                case .payLottery:
                    print("Pay Lottery Tapped")
                    return .none
                    
                case .receiveMoney:
                    print("Receive Money Tapped")
                    return .none
                }
            }
        }
    }
}
