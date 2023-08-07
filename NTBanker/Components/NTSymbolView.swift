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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(color)
            
            Image(systemName: sfSymbol.imageString)
                .foregroundStyle(.white)
        }
        .frame(width: 40, height: 40)
    }
}

#Preview {
    NTSymbolView(color: .blue, sfSymbol: .dollarSignCircle)
}
