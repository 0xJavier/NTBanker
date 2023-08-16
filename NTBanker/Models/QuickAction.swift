//
//  QuickAction.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import ComposableArchitecture
import SwiftUI

enum QuickActionType: Equatable, CaseIterable {
    case sendMoney
    case collect200
    case payBank
    case payLottery
    case receiveMoney
    
    static let actionList: [QuickAction] = QuickActionType.allCases.map { $0.action }
    
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

struct QuickAction: Equatable, Identifiable {
    var id = UUID()
    let title: String
    let image: SFSymbols
    let backgroundColor: Color
    let action: QuickActionType
}

extension QuickAction {
    static let placeholder = QuickAction(
        title: "Send Money",
        image: .dollarSignCircle,
        backgroundColor: .blue,
        action: .sendMoney
    )
}
