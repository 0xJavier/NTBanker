//
//  User.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import SwiftUI

struct User: Hashable, Codable {
    var userID: String = ""
    var name: String = ""
    var email: String = ""
    var balance: Int = 1500
    var color = CardColor.blue
    
    enum CodingKeys: String, CodingKey {
        case userID, name, email, balance, color
    }
}

extension User {
    static let placeholder = User(
        userID: "1",
        name: "Player",
        email: "test@banker.com",
        balance: 0,
        color: CardColor.blue
    )
    
    static let mockUserList = [
        User(userID: "1", name: "Player1", email: "a@b.com", balance: 2750, color: CardColor.blue),
        User(userID: "2", name: "Player2", email: "b@c.com", balance: 1500, color: CardColor.red),
        User(userID: "3", name: "Player3", email: "c@d.com", balance: 750, color: CardColor.green),
    ]
}
