//
//  SFSymbols.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import Foundation

enum SFSymbols {
    case dollarSignCircle
    case dollarSignSquare
    case house
    case personGroup
    case gear
    case person
    case buildingColumn
    case car
    
    var imageString: String {
        switch self {
        case .dollarSignCircle:
            return "dollarsign.circle.fill"
        case .dollarSignSquare:
            return "dollarsign.square"
        case .house:
            return "house"
        case .personGroup:
            return "person.2"
        case .gear:
            return "gear"
        case .person:
            return "person.fill"
        case .buildingColumn:
            return "building.columns.fill"
        case .car:
            return "car.fill"
        }
    }
}
