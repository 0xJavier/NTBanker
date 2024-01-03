//
//  QuickActionView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import ComposableArchitecture
import SwiftUI

struct QuickActionView: View {
    @Bindable var store: StoreOf<QuickActionFeature>
    
    var body: some View {
        VStack(alignment: .leading) {
            if !store.showActionSection {
                Text("Quick Actions")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(store.quickActions) { action in
                            QuickActionCardView(action: action)
                                .padding(.horizontal, 10)
                                .onTapGesture {
                                    store.send(
                                        .actionCellButtonTapped(action.action),
                                        animation: .bouncy
                                    )
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            if store.showActionSection {
                VStack(spacing: 10) {
                    HStack {
                        Text(store.sectionTitle)
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Button("Cancel") {
                            store.send(.clearActionState, animation: .bouncy)
                        }
                    }
                    
                    TextField("Amount", text: $store.amount)
                        .textFieldStyle(NTTextfieldStyle())
                        .keyboardType(.numberPad)
                    
                    NTLoadingButton(title: "\(store.sectionTitle)", isLoading: store.isLoading) {
                        store.send(.actionButtonTapped)
                    }
                    .disabled(store.shouldDisableButton)
                }
                .padding()
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .sheet(item: $store.scope(state: \.sendMoney, action: \.sendMoney)) { store in
            SendMoneyView(store: store)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.5)])
        }
    }
}

#Preview {
    QuickActionView(
        store: Store(initialState: QuickActionFeature.State()) {
            QuickActionFeature()
        }
    )
}
