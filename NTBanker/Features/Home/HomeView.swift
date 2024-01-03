//
//  HomeView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                NTCreditCardView(user: store.user)
                    .redacted(reason: store.user == .placeholder ? .placeholder : [])
                
                QuickActionView(
                    store: self.store.scope(
                        state: \.quickActions,
                        action: \.quickActions
                    )
                )
                
                TransactionView(
                    store: self.store.scope(
                        state: \.transactions,
                        action: \.transactions
                    )
                )
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            store.send(.viewOnAppear)
        }
    }
}

#Preview {
    HomeView(
        store: Store(initialState: HomeFeature.State()) {
            HomeFeature()
        }
    )
}
