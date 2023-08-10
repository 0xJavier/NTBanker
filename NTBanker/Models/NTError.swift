//
//  NTError.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import Foundation

enum NTError: Error, LocalizedError {
    /// Thrown when we are trying to 
    case noUserID
    
    var errorDescription: String? {
        switch self {
        case .noUserID:
            return NSLocalizedString(
                "Could not get current user's UID.",
                comment: ""
            )
        }
    }
}
