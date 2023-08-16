//
//  CardColor.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import SwiftUI

enum CardColor: String, CaseIterable, Codable {
    case blue
    case red
    case green
    case pink
    case purple
    case orange
    
    var colorLiteral: Color {
        switch self {
        case .blue:
            return .blue
        case .red:
            return .red
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
