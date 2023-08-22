//
//  TransactionActionType.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/16/23.
//

import Foundation

/// Custom type containing actions that can occur during a game. Used when creating `Transaction` models to save in Firebase.
enum TransactionActionType {
    /// Action for when the user pays another player.
    /// Takes in a String (player who the user wants to pay) and the amount they want to send.
    case paidPlayer(String, Int)
    /// Action for when the user receives money from another player.
    /// Takes in a String (player who paid the current) and the amount they were paid.
    case receivedMoneyFromPlayer(String, Int)
    /// Action for when a user wants to collect $200.
    case collect200
    /// Action for when the user pays the game bank.
    /// Takes in a Integer representing the amount they wish to pay.
    case paidBank(Int)
    /// Action for when the user pays the game lottery.
    /// Takes in a Integer representing the amount they wish to pay.
    case paidLottery(Int)
    /// Action for when the user receives money from the game bank.
    /// Takes in a Integer representing the amount they are to be paid.
    case receivedMoneyFromBank(Int)
    /// Action for when the user wins the Free Parking Lottery.
    /// Takes in a Integer representing the amount they won.
    case wonLottery(Int)
}
