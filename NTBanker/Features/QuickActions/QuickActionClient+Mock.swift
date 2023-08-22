//
//  QuickActionClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

extension QuickActionClient {
    /// Mock version of `QuickActionClient` that is used to power SwiftUI previews
    static var previewValue: Self {
        return Self(
            collect200: {
                try await Task.sleep(for: .milliseconds(500))
                return nil
            },
            
            payBank: { _ in
                try await Task.sleep(for: .milliseconds(500))
                return nil
            },
            
            payLottery: { _ in
                try await Task.sleep(for: .milliseconds(500))
                return nil
            },
            
            receiveMoney: { _ in
                try await Task.sleep(for: .milliseconds(500))
                return nil
            }
        )
    }
}

extension QuickActionClient {
    /// Mock version of `QuickActionClient` used when running tests.
    static let testValue = Self(
        collect200: unimplemented("\(Self.self).collect200"),
        payBank: unimplemented("\(Self.self).payBank"),
        payLottery: unimplemented("\(Self.self).payLottery"),
        receiveMoney: unimplemented("\(Self.self).receiveMoney")
    )
}
