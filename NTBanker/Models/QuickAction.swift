//
//  QuickAction.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import SwiftUI

/// Object representing quick actions a user can take during a game
struct QuickAction: Equatable, Identifiable {
    /// Unique identifier
    var id = UUID()
    /// Localizable title string for a given action
    let title: LocalizedStringResource
    /// Icon associated with the action which will be displayed in the quick action list
    let image: SFSymbols
    /// Background for the quick action icon view
    let backgroundColor: Color
    /// Action type associate for a given action which will be sent to a reducer
    let action: QuickActionType
}

/// Custom type representing all possible actions a user can take during a game. Enum forces us to exhaust new actions added in features / reducers
enum QuickActionType: Equatable, CaseIterable {
    case sendMoney
    case collect200
    case payBank
    case payLottery
    case receiveMoney
    
    /// List of all possible actions that will be displayed in a list on the home tab view
    static let actionList: [QuickAction] = QuickActionType.allCases.map { $0.action }
    
    /// `QuickAction` model associated with each case. Used to create the card view and send appropriate action to the reducer.
    var action: QuickAction {
        switch self {
        case .sendMoney:
            QuickAction(title: "Send Money", image: .paperPlane, backgroundColor: .blue, action: .sendMoney)
            
        case .collect200:
            QuickAction(title: "Collect $200", image: .dollarSignSquare, backgroundColor: .red, action: .collect200)
            
        case .payBank:
            QuickAction(title: "Pay\nBank", image: .buildingColumn, backgroundColor: .green, action: .payBank)
            
        case .payLottery:
            QuickAction(title: "Pay Lottery", image: .car, backgroundColor: .orange, action: .payLottery)
            
        case .receiveMoney:
            QuickAction(title: "Receive Money", image: .person, backgroundColor: .purple, action: .receiveMoney)
        }
    }
}

extension QuickAction {
    /// Mock action used for SwiftUI previews
    static let placeholder = QuickAction(
        title: "Send Money",
        image: .dollarSignCircle,
        backgroundColor: .blue,
        action: .sendMoney
    )
}
