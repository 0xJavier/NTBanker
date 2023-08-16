//
//  Transaction.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import Foundation
import FirebaseFirestore

struct Transaction: Codable, Equatable, Identifiable {
    var id = UUID().uuidString
    var createdAt = Timestamp()
    let title: String
    let subtitle: String
    let amount: Int
    let icon: SFSymbols
    
    enum CodingKeys: CodingKey {
        case id, createdAt, title, subtitle, amount, icon
    }
}

extension Transaction {
    init(action: TransactionActionType) {
        switch action {
        case .paidPlayer(let user, let amount):
            self.title = "Paid \(user.capitalized)"
            self.subtitle = "Sent"
            self.amount = -amount
            self.icon = .person
            
        case .receivedMoneyFromPlayer(let user, let amount):
            self.title = "Received money from \(user.capitalized)"
            self.subtitle = "Received"
            self.amount = amount
            self.icon = .person
            
        case .collect200:
            self.title = "Collected $200"
            self.subtitle = "Received"
            self.amount = 200
            self.icon = .dollarSignCircle
            
        case .paidBank(let amount):
            self.title = "Paid Bank"
            self.subtitle = "Sent"
            self.amount = -amount
            self.icon = .buildingColumn
            
        case .paidLottery(let amount):
            self.title = "Paid Lottery"
            self.subtitle = "Sent"
            self.amount = -amount
            self.icon = .car
            
        case .receivedMoneyFromBank(let amount):
            self.title = "Received money from Bank"
            self.subtitle = "Received"
            self.amount = amount
            self.icon = .buildingColumn
            
        case .wonLottery(let amount):
            self.title = "Won Lottery"
            self.subtitle = "Received"
            self.amount = amount
            self.icon = .dollarSignSquare
        }
    }
}

extension Transaction {
    static let mock = Transaction(title: "Mock Transaction", subtitle: "Sent", amount: 100, icon: .car)
    
    static let mockList: [Transaction] = [
        .init(action: .collect200),
        .init(action: .paidLottery(200)),
        .init(action: .paidPlayer("User", 100))
    ]
}
