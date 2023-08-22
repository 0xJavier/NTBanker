//
//  OSLogger+Extension.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/10/23.
//

import Foundation
import OSLog

/// Extension on Logger that will create custom loggers for specific app features.
extension Logger {
    /// Utilizing the app's bundle identifier to create a unique name for our logger
    private static var subsystem = Bundle.main.bundleIdentifier!
    /// Logs emitted from the `LoginFeature`
    static let login = Logger(subsystem: subsystem, category: "login")
    /// Logs emitted from the `SignupFeature`
    static let signup = Logger(subsystem: subsystem, category: "signup")
    /// Logs emitted from the Home
    static let home = Logger(subsystem: subsystem, category: "home")
    /// Logs emitted from the `QuickActionFeature`
    static let quickAction = Logger(subsystem: subsystem, category: "quickAction")
    /// Logs emitted from the `TransactionFeature`
    static let transaction = Logger(subsystem: subsystem, category: "transaction")
    /// Logs emitted from the `SendMoneyFeature`
    static let sendMoney = Logger(subsystem: subsystem, category: "sendMoney")
    /// Logs emitted from the `LotteryFeature`
    static let lottery = Logger(subsystem: subsystem, category: "lottery")
    /// Logs emitted from the `RankingFeature`
    static let ranking = Logger(subsystem: subsystem, category: "ranking")
    /// Logs emitted from the `SettingsFeature`
    static let settings = Logger(subsystem: subsystem, category: "settings")
}
