//
//  NTButton.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import SwiftUI

struct NTButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .frame(maxWidth: .infinity)
        })
        .tint(.blue)
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
}

#Preview {
    NTButton(title: "Hello, World!") {
        print("Button tapped!")
    }
    .padding(.horizontal)
}
