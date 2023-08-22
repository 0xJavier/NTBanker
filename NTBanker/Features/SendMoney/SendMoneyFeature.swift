//
//  SendMoneyFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture
import OSLog

/// Reducer containing state, actions, and the main reducer for `SendMoneyFeature`
struct SendMoneyFeature: Reducer {
    struct State: Equatable {
        /// Current list of all active users excluding the logged in user
        var userList = [User]()
        /// Currently selected user to send money to
        @BindingState var selectedUser = User.placeholder
        /// Amount the user wish to sends in string form. Used in textfields
        @BindingState var amount = ""
        /// Flag indicating if the view is fetching / sending data to Firebase
        @BindingState var isLoading = false
        /// State used to indicate when we show a user-facing alert
        @PresentationState var alert: AlertState<Action.Alert>?
        /// Amount string transformed to integer to use in Firebase
        var amountInt: Int {
            Int(amount) ?? 0
        }
    }
    
    enum Action: BindableAction {
        /// Actions an alert has available
        enum Alert: Equatable {}
        /// Actions done inside the iOS style alert
        case alert(PresentationAction<Alert>)
        /// Action that fires an effect to send money to a user in Firebase
        case sendMoneyButtonTapped
        /// Handles the response when sending money. If this fails, we present a user-facing alert
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
