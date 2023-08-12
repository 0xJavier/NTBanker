//
//  NTLoadingButton.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import SwiftUI

struct NTLoadingButton: View {
    var title: LocalizedStringResource
    @BindingState var isLoading: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action, label: {
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .controlSize(.regular)
                    .tint(.primary)
            } else {
                Text(title)
                    .frame(maxWidth: .infinity)
            }
        })
        .tint(.blue)
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
}

#Preview {
    VStack {
        NTLoadingButton(title: "Hello, World!", isLoading: false, action: {})
        NTLoadingButton(title: "Hello, World!", isLoading: true, action: {})
            .disabled(true)
    }
    .padding()
}
