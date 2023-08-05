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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    ForEach(viewStore.users, id: \.self) { user in
                        RankingCell(user: user)
                    }
                }
                .navigationTitle("Ranking")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                viewStore.send(.fetchUsers)
            }
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
