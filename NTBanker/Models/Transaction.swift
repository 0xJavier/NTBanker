//
//  Transaction.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import Foundation
import FirebaseFirestore

/// Object representing actions a user has take over the course of a game
struct Transaction: Codable, Equatable, Identifiable {
    /// Unique string identifier
    var id = UUID().uuidString
    /// Firebase time stamp used to order transactions
    var createdAt = Timestamp()
    /// Main title for the transaction. Created when initialized from a `TransactionActionType`
    let title: String
    /// Subtitle for the transaction. Will either be 'Sent' or 'Received'
    let subtitle: String
    /// Cost of the transaction. Can be positive or negative based on the action
    let amount: Int
    /// icon that will be displayed in the transaction list
    let icon: SFSymbols
    
    enum CodingKeys: CodingKey {
        case id, createdAt, title, subtitle, amount, icon
    }
}

extension Transaction {
    /// Creates a `Transaction` from a `TransactionActionType` and sets its field based on the type.
    ///
    /// - Parameter action: `TransactionActionType` enum dictating the action taken. Amount fields should only be positive
    /// as the initializer determines negative amounts based on the action.
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
    /// Single mocked transaction for previews.
    static let mock = Transaction(title: "Mock Transaction", subtitle: "Sent", amount: 100, icon: .car)
    
    /// List of placeholder transactions for previews.
    static let mockList: [Transaction] = [
        .init(action: .collect200),
        .init(action: .paidLottery(200)),
        .init(action: .paidPlayer("User", 100))
    ]
}
