//
//  SendMoneyFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture
import OSLog

@Reducer
struct SendMoneyFeature {
    @ObservableState
    struct State: Equatable {
        var userList = [User]()
        var selectedUser = User.placeholder
        var amount = ""
        var amountInt: Int {
            Int(amount) ?? 0
        }
        var isLoading = false
        /// State used to indicate when we show a user-facing alert
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action: BindableAction {
        /// Actions an alert has available
        enum Alert: Equatable {}
        /// Actions done inside the iOS style alert
        case alert(PresentationAction<Alert>)
        case sendMoneyButtonTapped
        case sendMoneyButtonTappedResponse(Error?)
        /// Action for binding state variables with `BindingState`
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.sendMoneyClient) var sendMoneyClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .alert:
                return .none
                
            case .binding:
                return .none
                
            case .sendMoneyButtonTapped:
                return .run { [user = state.selectedUser, amount = state.amountInt] send in
                    let response = try await sendMoneyClient.sendMoney(user, amount)
                    await send(.sendMoneyButtonTappedResponse(response))
                } catch: { error, send in
                    await send(.sendMoneyButtonTappedResponse(error))
                }
                
            case .sendMoneyButtonTappedResponse(let error):
                if let error {
                    Logger.sendMoney.error("Could not send money: \(error.localizedDescription)")
                    state.alert = AlertState {
                        TextState("Error sending money")
                    } message: {
                        TextState(error.localizedDescription)
                    }
                    return .none
                }
                
                state.alert = AlertState {
                    TextState("Successfully sent!")
                }
                
                return .none
            }
        }
    }
}
