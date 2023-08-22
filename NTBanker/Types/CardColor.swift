//
//  CardColor.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import SwiftUI

/// Custom type used to determine a user's selected card color.
enum CardColor: String, CaseIterable, Codable {
    case blue, red, green, pink, purple, orange
    
    /// SwiftUI representation of a given type.
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
