//
//  NTCardColorPickerView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import SwiftUI

struct NTCardColorPickerView: View {
    @Binding var selectedColor: CardColor
    
    var body: some View {
        HStack {
            Text("Card Color")
            
            Spacer()
            
            Picker("Card Color", selection: $selectedColor) {
                ForEach(CardColor.allCases, id: \.self) {
                    Text($0.rawValue.capitalized)
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(uiColor: .secondarySystemBackground))
        }
    }
}

#Preview {
    NTCardColorPickerView(selectedColor: .constant(.blue))
        .padding()
}
