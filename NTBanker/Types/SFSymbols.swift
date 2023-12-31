//
//  SFSymbols.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import Foundation

/// Custom type containing string values associated with SFSymbols to avoid stringly-typed variables.
enum SFSymbols: String, Codable {
    case dollarSignCircle = "dollarsign.circle.fill"
    case dollarSignSquare = "dollarsign.square.fill"
    case house = "house"
    case personGroup = "person.2"
    case gear = "gear"
    case person = "person.fill"
    case buildingColumn = "building.columns.fill"
    case car = "car.fill"
    case paperPlane = "paperplane.fill"
    case chevronRight = "chevron.right"
}
