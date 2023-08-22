//
//  User.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import SwiftUI

/// Object representing a user / player
struct User: Identifiable ,Equatable, Hashable, Codable {
    /// User's unique UID created from Firebase
    var id: String
    /// User's name
    var name: String
    /// User's current game balance
    var balance: Int
    /// User's selected card color.
    var color: CardColor
    
    enum CodingKeys: String, CodingKey {
        case id, name, balance, color
    }
}

extension User {
    /// Mock user used for SwiftUI Previews
    static let placeholder = User(
        id: "1",
        name: "Player",
        balance: 0,
        color: .blue
    )
    
    /// Mock list of users used for SwiftUI Previews
    static let mockUserList = [
        User(id: "1", name: "Player1", balance: 2750, color: .blue),
        User(id: "2", name: "Player2", balance: 1500, color: .red),
        User(id: "3", name: "Player3", balance: 750, color: .green)
    ]
}
