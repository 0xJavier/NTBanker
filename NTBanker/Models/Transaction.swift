//
//  Transaction.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import Foundation

struct Transaction: Codable, Equatable, Identifiable {
    var id: Int = Int(Date().timeIntervalSince1970)
    let amount: Int
    let action: String
    let subAction: String
    let type: String
    
    init(amount: Int, action: String, subAction: String, type: String, id: Int) {
        self.amount = amount
        self.action = action
        self.subAction = subAction
        self.type = type
        self.id = id
    }
    
//    enum CodingKeys: String, CodingKey {
//        case id, amount, action, subAction, type
//    }
        
//    init(amount: Int, action: String, subAction: TransactionModelType, type: TransactionActionType) {
//        self.amount = amount
//        self.action = action
//        self.subAction = subAction.rawValue
//        self.type = type.rawValue
//    }
}

extension Transaction {
    static let mock = Transaction(
        amount: 200,
        action: "Collected $200",
        subAction: "Received",
        type: "type",
        id: 1
    )
    
    static let mockList: [Transaction] = [
        .init(amount: 200, action: "Collected $200", subAction: "Received", type: "type", id: 1),
        .init(amount: -50, action: "Paid Lottery", subAction: "Sent", type: "type", id: 2),
        .init(amount: -400, action: "Paid Player", subAction: "Sent", type: "type", id: 3),
    ]
}
