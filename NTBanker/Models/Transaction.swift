//
//  Transaction.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import Foundation
import FirebaseFirestore

struct NewTransaction: Codable, Equatable, Identifiable {
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

extension NewTransaction {
    init(action: NewTransactionActionType) {
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

extension NewTransaction {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        createdAt = try container.decode(Timestamp.self, forKey: .createdAt)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        amount = try container.decode(Int.self, forKey: .amount)
        icon = try container.decode(SFSymbols.self, forKey: .icon)
    }
}

extension NewTransaction {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.subtitle, forKey: .subtitle)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.icon.rawValue, forKey: .icon)
    }
}

extension NewTransaction {
    static let mock = NewTransaction(title: "Mock Transaction", subtitle: "Sent", amount: 100, icon: .car)
    
    static let mockList: [NewTransaction] = [
        .init(action: .collect200),
        .init(action: .paidLottery(200)),
        .init(action: .paidPlayer("User", 100))
    ]
}
