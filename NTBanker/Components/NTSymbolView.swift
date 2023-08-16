//
//  NTSymbolView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import SwiftUI

struct NTSymbolView: View {
    let color: Color
    let sfSymbol: SFSymbols
    
    init(color: Color, sfSymbol: SFSymbols) {
        self.color = color
        self.sfSymbol = sfSymbol
    }
    
    init(quickAction: QuickAction) {
        self.color = quickAction.backgroundColor
        self.sfSymbol = quickAction.image
    }
    
    init(icon: SFSymbols) {
        self.sfSymbol = icon
        
        switch icon {
        case .dollarSignCircle, .dollarSignSquare:
            self.color = .red
        case .person:
            self.color = .blue
        case .buildingColumn:
            self.color = .green
        case .car:
            self.color = .orange
        default:
            print("Symbol not support")
            self.color = .blue
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(color)
            
            Image(systemName: sfSymbol.rawValue)
                .foregroundStyle(.white)
        }
        .frame(width: 40, height: 40)
    }
}

#Preview {
    NTSymbolView(color: .blue, sfSymbol: .dollarSignCircle)
}
