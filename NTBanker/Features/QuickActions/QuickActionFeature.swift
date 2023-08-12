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
        @PresentationState var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {}
        
        case actionButtonTapped(QuickActionType)
        case collect200
        case collect200Response(Error?)
        case payBank(Int)
        case payBankResponse(Error?)
        case payLottery(Int)
        case payLotteryResponse(Error?)
        case receiveMoney(Int)
        case receiveMoneyResponse(Error?)
    }
    
    @Dependency(\.quickActionClient) var quickActionClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert:
                return .none
                
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
                    return .run { send in
                        await send(.payLottery(500))
                    }
                    print("Pay Lottery Tapped")
                    return .none
                    
                case .receiveMoney:
                    return .run { send in
                        await send(.receiveMoney(350))
                    }
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
                
                state.alert = AlertState {
                    TextState("Successfully collected $200")
                }
                
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
                
                state.alert = AlertState {
                    TextState("Successfully paid bank")
                }
                
                return .none
                
            case .payLottery(let amount):
                return .run { send in
                    let response = try await self.quickActionClient.payLottery(amount)
                    await send(.payLotteryResponse(response))
                }
                
            case .payLotteryResponse(let error):
                if let error {
                    print("ERROR: \(error.localizedDescription)")
                    return .none
                }
                
                state.alert = AlertState {
                    TextState("Successfully paid lottery")
                }
                
                return .none
                
            case .receiveMoney(let amount):
                return .run { send in
                    let response = try await self.quickActionClient.receiveMoney(amount)
                    await send(.receiveMoneyResponse(response))
                }
                
            case .receiveMoneyResponse(let error):
                if let error {
                    print("ERROR: \(error.localizedDescription)")
                    return .none
                }
                
                state.alert = AlertState {
                    TextState("Successfully received money")
                }
                
                return .none
                
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}
