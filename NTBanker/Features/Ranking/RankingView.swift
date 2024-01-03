//
//  RankingView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import SwiftUI

struct RankingView: View {
    let store: StoreOf<RankingFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.users) { user in
                    RankingCell(user: user)
                }
            }
            .navigationTitle("Ranking")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            store.send(.viewOnAppear)
        }
    }
}

struct RankingCell: View {
    let user: User
    
    var body: some View {
        HStack {
            Text(user.name)
            
            Spacer()
            
            Text("$\(user.balance)")
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    RankingView(
        store: Store(initialState: RankingFeature.State()) {
            RankingFeature()
        }
    )
}
