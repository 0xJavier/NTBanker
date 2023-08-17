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
        var showActionSection = false
        var selectedAction: QuickActionType?
        @BindingState var amount = ""
        @PresentationState var alert: AlertState<Action.Alert>?
        @PresentationState var sendMoney: SendMoneyFeature.State?
        @BindingState var isLoading = false
        
        var sectionTitle: String {
            guard let selectedAction = selectedAction else {
                return "Button"
            }
            
            switch selectedAction {
            case .payBank:
                return "Pay Bank"
            case .payLottery:
                return "Pay Lottery"
            case .receiveMoney:
                return "Receive Money"
            case .sendMoney, .collect200:
                print("SHOULD BE HANDLED OUTSIDE OF SECTION")
                return "Section Title"
            }
        }
        
        var formattedAmount: Int {
            Int(amount) ?? 0
        }
        
        var shouldDisableButton: Bool {
            formattedAmount <= 0
        }
    }
    
    enum Action: BindableAction {
        /// Actions an alert has available
        enum Alert: Equatable {}
        ///
        case alert(PresentationAction<Alert>)
        /// Resets the state by hiding the action section and deselecting any action
        case clearActionState
        /// Action to present the sheet view to send money
        case sendMoney(PresentationAction<SendMoneyFeature.Action>)
        /// Action to fetch the list of active players before showing sheet
        case fetchUserList
        /// Response from action
        case fetchUserListResponse(TaskResult<[User]>)
        /// Shows the action section and configures the action tapped
        case actionCellButtonTapped(QuickActionType)
        /// Main button in action section is tapped
        case actionButtonTapped
        case collect200
        case actionResponse(Error?)
        /// Action for binding state variables with `BindingState`
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.quickActionClient) var quickActionClient
    @Dependency(\.sendMoneyClient) var sendMoneyClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .sendMoney:
                return .none
                
            case .alert:
                return .none
                
            case .actionCellButtonTapped(let action):
                switch action {
                case .sendMoney:
                    return .run { send in
                        let response = await TaskResult { try await sendMoneyClient.getActiveUsers() }
                        await send(.fetchUserListResponse(response))
                    }
                    
                case .collect200:
                    return .run { send in
                        await send(.collect200)
                    }
                    
                case .payBank, .payLottery, .receiveMoney:
                    state.showActionSection = true
                    state.selectedAction = action
                    return .none
                }
                
            case .actionButtonTapped:
                guard let action = state.selectedAction else {
                    print("Could not get action")
                    return .none
                }
                
                switch action {
                case .sendMoney, .collect200:
                    print("ACTION SHOULD BE TAKEN CARE OF ELSEWHERE")
                    return .none

                case .payBank:
                    state.isLoading = true
                    return .run { [amount = state.formattedAmount] send in
                        let response = try await self.quickActionClient.payBank(amount)
                        await send(.actionResponse(response))
                    }
                    
                case .payLottery:
                    state.isLoading = true
                    return .run { [amount = state.formattedAmount] send in
                        let response = try await self.quickActionClient.payLottery(amount)
                        await send(.actionResponse(response))
                    }
                    
                case .receiveMoney:
                    state.isLoading = true
                    return .run { [amount = state.formattedAmount] send in
                        let response = try await self.quickActionClient.receiveMoney(amount)
                        await send(.actionResponse(response))
                    }
                }
                
            case .clearActionState:
                state.showActionSection = false
                state.selectedAction = nil
                state.amount = ""
                return .none
                
            case .fetchUserList:
                return .run { send in
                    let response = await TaskResult { try await sendMoneyClient.getActiveUsers() }
                    await send(.fetchUserListResponse(response))
                }
                
            case .fetchUserListResponse(.success(let users)):
                state.sendMoney = SendMoneyFeature.State(userList: users, selectedUser: users.first!)                
                return .none
                
            case .fetchUserListResponse(.failure(let error)):
                print("ERROR FETCHING USERS: \(error.localizedDescription)")
                return .none
                
            case .collect200:
                return .run { send in
                    let response = try await self.quickActionClient.collect200()
                    await send(.actionResponse(response))
                }
                
            case .actionResponse(let error):
                state.isLoading = false
                if let error {
                    print("ERROR: \(error.localizedDescription)")
                    return .run { send in
                        await send(.clearActionState)
                    }
                }
                
                state.alert = AlertState {
                    TextState("Success")
                }
                
                return .run { send in
                    await send(.clearActionState)
                }
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
        .ifLet(\.$sendMoney, action: /Action.sendMoney) {
            SendMoneyFeature()
        }
    }
}
