//
//  SFSymbols.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/3/23.
//

import Foundation

enum SFSymbols {
    case dollarSignCircle
    
    var imageString: String {
        switch self {
        case .dollarSignCircle:
            return "dollarsign.circle.fill"
        }
    }
}
