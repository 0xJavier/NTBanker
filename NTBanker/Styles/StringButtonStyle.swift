//
//  StringButtonStyle.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import SwiftUI

struct ButtonStringModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .bold()
    }
}

extension View {
    func stringButtonStyle() -> some View {
        modifier(ButtonStringModifier())
    }
}
