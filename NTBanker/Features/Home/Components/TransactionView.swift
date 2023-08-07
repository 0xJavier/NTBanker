//
//  TransactionView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import ComposableArchitecture
import SwiftUI

struct TransactionView: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Text("Latest Transactions")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                List(viewStore.transactions) { transaction in
                    TransactionCell(transaction: transaction)
                }
                .listStyle(.plain)
            }
        }
    }
}

struct TransactionCell: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            NTSymbolView(color: .red, sfSymbol: .dollarSignCircle)
            
            VStack(alignment: .leading) {
                Text(transaction.action)
                
                Text(transaction.subAction)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("$\(transaction.amount)")
                .font(.title3)
                .foregroundStyle(transaction.amount >= 0 ? Color.primary : Color.red)
        }
    }
}

#Preview {
    TransactionView(
        store: Store(initialState: HomeFeature.State()) {
            HomeFeature()
        }
    )
}
