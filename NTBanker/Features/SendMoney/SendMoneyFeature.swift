//
//  SendMoneyFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture

struct SendMoneyFeature: Reducer {
    struct State: Equatable {
        var userList = [User]()
        @BindingState var selectedUser = User.placeholder
        @BindingState var amount = ""
        @BindingState var isLoading = false
        
        var amountInt: Int {
            Int(amount) ?? 0
        }
    }
    
    enum Action: BindableAction {
        case sendMoneyButtonTapped
        case sendMoneyButtonTappedResponse(Error?)
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.sendMoneyClient) var sendMoneyClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                print("User Changed")
                return .none
                
            case .sendMoneyButtonTapped:
                return .run { [user = state.selectedUser, amount = state.amountInt] send in
                    let response = try await sendMoneyClient.sendMoney(user, amount)
                    await send(.sendMoneyButtonTappedResponse(response))
                } catch: { error, _ in
                    print("ERROR IN CATCH BLOCK: \(error.localizedDescription)")
                }
                
            case .sendMoneyButtonTappedResponse(let error):
                if let error {
                    print("ERROR SENDING MONEY: \(error.localizedDescription)")
                    return .none
                }
                
                print("SUCCESS!")
                return .none
            }
        }
    }
}
