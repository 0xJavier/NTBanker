//
//  Transaction.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import Foundation

enum TransactionActionType: String {
    case paidPlayer
    case receivedMoneyFromPlayer
    case collect200
    case paidBank
    case paidLottery
    case receivedMoneyFromBank
    case wonLottery
}

enum TransactionModelType: String {
    case amount, action, subAction, type, id, sent, received
}

struct Transaction: Codable, Equatable, Identifiable {
    var id: Int = Int(Date().timeIntervalSince1970)
    let amount: Int
    let action: String
    let subAction: String
    let type: String
        
    enum CodingKeys: String, CodingKey {
        case id, amount, action, subAction, type
    }
        
    init(amount: Int, action: String, subAction: TransactionModelType, type: TransactionActionType) {
        self.amount = amount
        self.action = action
        self.subAction = subAction.rawValue
        self.type = type.rawValue
    }
}

extension Transaction {
    static let mock = Transaction(
        amount: 200,
        action: "Collected $200",
        subAction: .received,
        type: .collect200
    )
    
    static let mockList: [Transaction] = [
        .init(amount: 200, action: "Collected $200", subAction: .received, type: .collect200),
        .init(amount: -50, action: "Paid Lottery", subAction: .sent, type: .paidLottery),
        .init(amount: -400, action: "Paid Player", subAction: .sent, type: .paidPlayer)
    ]
}
