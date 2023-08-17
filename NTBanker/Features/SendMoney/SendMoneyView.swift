//
//  SendMoneyView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/17/23.
//

import ComposableArchitecture
import SwiftUI

struct SendMoneyView: View {
    let store: StoreOf<SendMoneyFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                Form {
                    Section {
                        Picker("User", selection: viewStore.$selectedUser) {
                            ForEach(viewStore.userList) { user in
                                Text(user.name)
                                    .tag(user)
                            }
                        }
                     
                        TextField("Amount", text: viewStore.$amount)
                            .keyboardType(.numberPad)
                    }

                    Section {
                        Button("Send Money") {
                            viewStore.send(.sendMoneyButtonTapped)
                        }
                        .disabled(viewStore.amount.isEmpty)
                    }
                }
                .pickerStyle(.navigationLink)
                .navigationTitle("Send Money")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    SendMoneyView(
        store: Store(initialState: SendMoneyFeature.State()) {
            SendMoneyFeature()
        }
    )
}
