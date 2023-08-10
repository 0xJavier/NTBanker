//
//  LotteryView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import ComposableArchitecture
import SwiftUI

struct LotteryView: View {
    let store: StoreOf<LotteryFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    Text("Free Parking Lottery")
                        .padding(.top, 85)
                        .font(.title2)
                        .bold()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 95)
                            .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                        
                        Text("$\(viewStore.lotteryAmount)")
                            .foregroundStyle(.blue)
                            .font(.system(size: 50, weight: .bold))
                    }
                    
                    NTLoadingButton(title: "Collect", isLoading: viewStore.isLoading) {
                        viewStore.send(.collectButtonTapped)
                    }
                    .disabled(viewStore.shouldDisableCollectButton)
                    
                    Spacer()
                }
                .navigationTitle("Lottery")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.horizontal)
                .onAppear {
                    self.store.send(.retrieveLotteryAmount)
                }
            }
        }
    }
}

#Preview {
    LotteryView(
        store: Store(initialState: LotteryFeature.State()) {
            LotteryFeature()
        }
    )
}
