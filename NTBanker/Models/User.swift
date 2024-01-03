//
//  User.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import SwiftUI

/// Object representing a user / player
struct User: Identifiable ,Equatable, Hashable, Codable {
    var id: String
    var name: String
    var email: String
    var balance: Int
    var color: CardColor
    
    enum CodingKeys: String, CodingKey {
        case id = "userID"
        case name, email, balance, color
    }
}

extension User {
    /// Mock user used for SwiftUI Previews
    static let placeholder = User(
        id: "1",
        name: "Player",
        email: "placeholder@ntbanker.com",
        balance: 0,
        color: .blue
    )
    
    /// Mock list of users used for SwiftUI Previews
    static let mockUserList = [
        User(id: "1", name: "Player1", email: "a@b.com", balance: 2750, color: .blue),
        User(id: "2", name: "Player2", email: "b@c.com", balance: 1500, color: .red),
        User(id: "3", name: "Player3", email: "c@d.com", balance: 750, color: .green)
    ]
}
