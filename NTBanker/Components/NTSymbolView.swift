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
    
    init(typeString: String) {
        guard let type = TransactionActionType(rawValue: typeString) else {
            print("COULD NOT CONVERT STRING")
            self.color = .blue
            self.sfSymbol = .car
            return
        }
        
        switch type {
        case .paidPlayer, .receivedMoneyFromPlayer:
            self.color = .blue
            self.sfSymbol = .person
        case .collect200:
            self.color = .red
            self.sfSymbol = .dollarSignSquare
        case .paidBank:
            self.color = .green
            self.sfSymbol = .buildingColumn
        case .paidLottery:
            self.color = .orange
            self.sfSymbol = .car
        case .receivedMoneyFromBank:
            self.color = .green
            self.sfSymbol = .buildingColumn
        case .wonLottery:
            self.color = .orange
            self.sfSymbol = .car
        }
    }
    
    init(color: Color, sfSymbol: SFSymbols) {
        self.color = color
        self.sfSymbol = sfSymbol
    }
    
    init(type: TransactionActionType) {
        switch type {
        case .paidPlayer, .receivedMoneyFromPlayer:
            self.color = .blue
            self.sfSymbol = .person
        case .collect200:
            self.color = .red
            self.sfSymbol = .dollarSignSquare
        case .paidBank:
            self.color = .green
            self.sfSymbol = .buildingColumn
        case .paidLottery:
            self.color = .orange
            self.sfSymbol = .car
        case .receivedMoneyFromBank:
            self.color = .green
            self.sfSymbol = .buildingColumn
        case .wonLottery:
            self.color = .orange
            self.sfSymbol = .car
        }
    }
    
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
