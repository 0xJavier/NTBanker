//
//  QuickActionFeature.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture
import OSLog

@Reducer
struct QuickActionFeature {
    @ObservableState
    struct State: Equatable {
        let quickActions = QuickActionType.actionList
        var showActionSection = false
        var selectedAction: QuickActionType?
        var amount = ""
        var isLoading = false
        /// Computed property to determine the action section title string
        var sectionTitle: LocalizedStringResource {
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
                Logger.quickAction.warning("These actions should not be shown in action section")
                return "Section Title"
            }
        }
        var formattedAmount: Int {
            Int(amount) ?? 0
        }
        var shouldDisableButton: Bool {
            formattedAmount <= 0
        }
        /// iOS style alert to show to user for when a action is complete
        @Presents var alert: AlertState<Action.Alert>?
        /// Flag used to show or hide the `SendMoneyFeature` sheet
        @Presents var sendMoney: SendMoneyFeature.State?
    }
    
    enum Action: BindableAction {
        /// Actions an alert has available
        enum Alert: Equatable {}
        /// Actions done inside the iOS style alert
        case alert(PresentationAction<Alert>)
        case clearActionState
        /// Action to present the sheet view to send money
        case sendMoney(PresentationAction<SendMoneyFeature.Action>)
        case fetchUserList
        case fetchUserListResponse(TaskResult<[User]>)
        case actionCellButtonTapped(QuickActionType)
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
                    Logger.quickAction.error("Action button tapped but state.selectedAction is not valid.")
                    return .none
                }
                
                switch action {
                case .sendMoney, .collect200:
                    // Should be handled in the scoped domain.
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
                Logger.quickAction.error("Error fetching current user list: \(error.localizedDescription)")
                state.sendMoney = nil
                return .none
                
            case .collect200:
                return .run { send in
                    let response = try await self.quickActionClient.collect200()
                    await send(.actionResponse(response))
                }
                
            case .actionResponse(let error):
                state.isLoading = false
                if let error {
                    Logger.quickAction.error("Could not complete action: \(error.localizedDescription)")
                    
                    state.alert = AlertState {
                        TextState("Error")
                    } message: {
                        TextState(error.localizedDescription)
                    }
                } else {
                    state.alert = AlertState {
                        TextState("Success")
                    }
                }

                return .send(.clearActionState)
            }
        }
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.$sendMoney, action: \.sendMoney) {
            SendMoneyFeature()
        }
    }
}
