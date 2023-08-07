//
//  QuickActionCardView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import SwiftUI

struct QuickActionCardView: View {
    let action: QuickAction
    
    var body: some View {
        VStack {
            NTSymbolView(color: action.backgroundColor, sfSymbol: action.image)
            
            Text(action.title)
                .multilineTextAlignment(.center)
        }
        .frame(width: 80, height: 100)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(uiColor: .secondarySystemBackground))
        }
    }
}

#Preview {
    QuickActionCardView(action: QuickAction.placeholder)
}
