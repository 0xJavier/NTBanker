//
//  TransactionActionType.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/16/23.
//

import Foundation

enum TransactionActionType {
    case paidPlayer(String, Int)
    case receivedMoneyFromPlayer(String, Int)
    case collect200
    case paidBank(Int)
    case paidLottery(Int)
    case receivedMoneyFromBank(Int)
    case wonLottery(Int)
}
