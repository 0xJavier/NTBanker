//
//  FirebaseStringType.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/9/23.
//

import Foundation

/// Custom enum containing string values associated with Firebase to avoid stringly-typed variables.
enum FirebaseStringType: String {
    case amount, players, lottery, balance, transactions
}
