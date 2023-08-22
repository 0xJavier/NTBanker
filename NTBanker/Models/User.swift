//
//  User.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import SwiftUI

/// Object representing a user / player
struct User: Identifiable ,Equatable, Hashable, Codable {
    /// Unique identifier
    var id = UUID()
    /// User's unique uid created from Firebase
    var userID: String = ""
    /// User's name
    var name: String = ""
    /// User's associated email
    var email: String = ""
    /// User's current game balance
    var balance: Int = 1500
    /// User's selected card color.
    var color: CardColor = .blue
    
    enum CodingKeys: String, CodingKey {
        case userID, name, email, balance, color
    }
}

extension User {
    /// Mock user used for SwiftUI Previews
    static let placeholder = User(
        userID: "1",
        name: "Player",
        email: "test@banker.com",
        balance: 0,
        color: .blue
    )
    
    /// Mock list of users used for SwiftUI Previews
    static let mockUserList = [
        User(userID: "1", name: "Player1", email: "a@b.com", balance: 2750, color: .blue),
        User(userID: "2", name: "Player2", email: "b@c.com", balance: 1500, color: .red),
        User(userID: "3", name: "Player3", email: "c@d.com", balance: 750, color: .green),
    ]
}
