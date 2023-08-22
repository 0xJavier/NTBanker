//
//  TransactionView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import ComposableArchitecture
import SwiftUI

struct TransactionView: View {
    let store: StoreOf<TransactionFeature>
    
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
            .onAppear {
                viewStore.send(.viewOnAppear)
            }
        }
    }
}

struct TransactionCell: View {
    let transaction: Transaction
    var amountColor: Color {
        transaction.amount >= 0 ? Color.primary : Color.red
    }
    
    var body: some View {
        HStack {
            NTSymbolView(icon: transaction.icon)
            
            VStack(alignment: .leading) {
                Text(transaction.title)
                
                Text(transaction.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("$\(transaction.amount)")
                .font(.title3)
                .foregroundStyle(amountColor)
        }
    }
}

#Preview {
    TransactionView(
        store: Store(initialState: TransactionFeature.State()) {
            TransactionFeature()
        }
    )
}
