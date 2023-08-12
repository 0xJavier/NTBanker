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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack(spacing: 10) {
                    NTCreditCardView(user: viewStore.user)
                    
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
                viewStore.send(.streamUser)
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
