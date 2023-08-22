//
//  NTError.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import Foundation

enum NTError: Error, LocalizedError {
    /// Thrown when trying to get the current logged in userID
    case noUserID
    /// Thrown when attempting to get documents from a query snapshot.
    case documentError
    
    var errorDescription: String? {
        switch self {
        case .noUserID:
            return NSLocalizedString(
                "Could not get current user's UID.",
                comment: ""
            )
        case .documentError:
            return NSLocalizedString(
                "Could not get documents from querySnapshot",
                comment: ""
            )
        }
    }
}
