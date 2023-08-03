//
//  NTLoadingButton.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import SwiftUI

struct NTLoadingButton: View {
    let title: String
    @Binding var isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: self.action, label: {
            if isLoading {
                ProgressView()
                    .controlSize(.regular)
                    .frame(maxWidth: .infinity)
            } else {
                Text(self.title)
                    .frame(maxWidth: .infinity)
            }
        })
        .buttonStyle(.bordered)
        .tint(.blue)
        .controlSize(.large)
    }
}

#Preview {
    VStack {
        NTLoadingButton(title: "Hello, World!", isLoading: .constant(false), action: {})
        
        NTLoadingButton(title: "Loading", isLoading: .constant(true), action: {})
    }
    .padding(.horizontal)
}
