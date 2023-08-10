//
//  QuickActionClient+Mock.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/11/23.
//

import ComposableArchitecture

extension QuickActionClient {
    static var previewValue: Self {
        return Self(
            collect200: {
                try await Task.sleep(for: .milliseconds(500))
                return nil
            },
            
            payBank: { _ in
                try await Task.sleep(for: .milliseconds(500))
                return nil
            }
        )
    }
}

extension QuickActionClient {
    static let testValue = Self(
        collect200: unimplemented("\(Self.self).collect200"),
        payBank: unimplemented("\(Self.self).payBank")
    )
}
