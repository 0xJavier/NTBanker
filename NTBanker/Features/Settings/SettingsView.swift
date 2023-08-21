//
//  SettingsView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
    let store: StoreOf<SettingsFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                Form {
                    // User Header
                    Section {
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(viewStore.user.color.colorLiteral)
                                
                                Image(systemName: SFSymbols.person.rawValue)
                                    .foregroundStyle(.white)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(viewStore.user.name)
                                
                                Text(viewStore.user.email)
                            }
                        }
                    }
                    
                    // Actions
                    Section {
                        SettingsCell(title: "Sign Out") {
                            viewStore.send(.signOut)
                        }
                    }
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .redacted(reason: viewStore.user == .placeholder ? .placeholder : [])
                
            }
            .onAppear {
                viewStore.send(.fetchUser)
            }
        }
    }
}

struct SettingsCell: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(title)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    SettingsView(
        store: Store(initialState: SettingsFeature.State()) {
            SettingsFeature()
        }
    )
}
