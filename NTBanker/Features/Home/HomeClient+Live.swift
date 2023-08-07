//
//  HomeClient+Live.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture

extension HomeClient {
    static let liveValue = Self(
        streamUser: {
            return User.placeholder
        }, streamTransactions: {
            return Transaction.mockList
        }
    )
}
