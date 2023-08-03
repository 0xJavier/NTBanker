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
        name: "Placeholder User",
        email: "test@banker.com",
        balance: 1500,
        color: CardColor.blue.rawValue
    )
}
