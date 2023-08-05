//
//  User.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import OSLog
import SwiftUI

private let logger = Logger(subsystem: "NTBanker", category: "UserModel")

struct User: Hashable, Codable {
    var userID: String = ""
    var name: String = ""
    var email: String = ""
    var balance: Int = 0
    var color: String = CardColor.blue.rawValue
    
    var colorLiteral: Color {
        guard let colorType = CardColor.init(rawValue: color) else {
            logger.error("Could not create color type with current color of \(color). Defaulting to blue.")
            return .blue
        }
        
        switch colorType {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        case .pink:
            return .pink
        case .purple:
            return .purple
        case .orange:
            return .orange
        }
    }
}

extension User {
    static let placeholder = User(
        userID: "123",
        name: "Player",
        email: "test@banker.com",
        balance: 1500,
        color: CardColor.blue.rawValue
    )
    
    static let mockUserList = [
        User(userID: "1", name: "Player1", email: "a@b.com", balance: 2750, color: CardColor.blue.rawValue),
        User(userID: "2", name: "Player2", email: "b@c.com", balance: 1500, color: CardColor.red.rawValue),
        User(userID: "3", name: "Player3", email: "c@d.com", balance: 750, color: CardColor.green.rawValue),
    ]
}
