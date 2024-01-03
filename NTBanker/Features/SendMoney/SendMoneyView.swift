//
//  SendMoneyView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture
import SwiftUI

struct SendMoneyView: View {
    @Bindable var store: StoreOf<SendMoneyFeature>
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("User", selection: $store.selectedUser) {
                        ForEach(store.userList) { user in
                            Text(user.name)
                                .tag(user)
                        }
                    }
                    
                    TextField("Amount", text: $store.amount)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button("Send Money") {
                        store.send(.sendMoneyButtonTapped)
                    }
                    .disabled(store.amount.isEmpty)
                }
            }
            .pickerStyle(.navigationLink)
            .navigationTitle("Send Money")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    SendMoneyView(
        store: Store(initialState: SendMoneyFeature.State()) {
            SendMoneyFeature()
        }
    )
}
