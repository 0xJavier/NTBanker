//
//  LotteryView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import SwiftUI

struct LotteryView: View {
    @Bindable var store: StoreOf<LotteryFeature>
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Free Parking Lottery")
                    .multilineTextAlignment(.center)
                    .padding(.top, 85)
                    .font(.title2)
                    .bold()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 95)
                        .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                    
                    Text("$\(store.lotteryAmount)")
                        .foregroundStyle(.blue)
                        .font(.system(size: 50, weight: .bold))
                }
                
                NTLoadingButton(title: "Collect", isLoading: store.isLoading) {
                    store.send(.collectButtonTapped)
                }
                .disabled(store.shouldDisableCollectButton)
                
                Spacer()
            }
            .navigationTitle("Lottery")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
            .onAppear {
                store.send(.viewOnAppear)
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    LotteryView(
        store: Store(initialState: LotteryFeature.State()) {
            LotteryFeature()
        }
    )
}
