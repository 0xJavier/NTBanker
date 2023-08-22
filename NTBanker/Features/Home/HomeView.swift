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
        WithViewStore(self.store, observe: \.user) { viewStore in
            NavigationStack {
                VStack(spacing: 10) {
                    NTCreditCardView(user: viewStore.state)
                        .redacted(reason: viewStore.state == .placeholder ? .placeholder : [])
                    
                    QuickActionView(
                        store: self.store.scope(
                            state: \.quickActions,
                            action: HomeFeature.Action.quickActions
                        )
                    )
                    
                    TransactionView(
                        store: self.store.scope(
                            state: \.transactions,
                            action: HomeFeature.Action.transactions
                        )
                    )
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                viewStore.send(.viewOnAppear)
            }
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
