//
//  QuickActionView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import ComposableArchitecture
import SwiftUI

struct QuickActionView: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Text("Quick Actions")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(viewStore.quickActions) { action in
                            QuickActionCardView(action: action)
                                .padding(.horizontal, 10)
                                .onTapGesture {
                                    viewStore.send(.actionButtonTapped(action.action))
                                }
                                
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    QuickActionView(
        store: Store(initialState: HomeFeature.State()) {
            HomeFeature()
        }
    )
}
