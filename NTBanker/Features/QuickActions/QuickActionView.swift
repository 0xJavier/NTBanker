//
//  QuickActionView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/7/23.
//

import ComposableArchitecture
import SwiftUI

struct QuickActionView: View {
    let store: StoreOf<QuickActionFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                if !viewStore.showActionSection {
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
                                        viewStore.send(.actionCellButtonTapped(action.action), animation: .bouncy)
                                    }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                if viewStore.showActionSection {
                    VStack(spacing: 10) {
                        HStack {
                            Text(viewStore.sectionTitle)
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            Button("Cancel") {
                                viewStore.send(.clearActionState, animation: .bouncy)
                            }
                        }
                        
                        TextField("Amount", text: viewStore.$amount)
                            .textFieldStyle(NTTextfieldStyle())
                            .keyboardType(.numberPad)
                        
                        NTLoadingButton(title: "\(viewStore.sectionTitle)", isLoading: viewStore.isLoading) {
                            viewStore.send(.actionButtonTapped)
                        }
                        .disabled(viewStore.shouldDisableButton)
                    }
                    .padding()
                }
            }
            .alert(store: self.store.scope(state: \.$alert, action: QuickActionFeature.Action.alert))
            .sheet(store: self.store.scope(state: \.$sendMoney, action: { .sendMoney($0) })) { store in
                SendMoneyView(store: store)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.5)])
            }
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
