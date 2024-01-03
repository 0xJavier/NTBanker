//
//  SettingsView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/21/23.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
    @Bindable var store: StoreOf<SettingsFeature>
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - User Header
                Section {
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(store.user.color.colorLiteral)
                            
                            Image(systemName: SFSymbols.person.rawValue)
                                .foregroundStyle(.white)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(store.user.name)
                            
                            Text("$\(store.user.balance)")
                        }
                    }
                }
                
                // MARK: - Actions
                Section {
                    SettingsCell(title: "Sign Out") {
                        store.send(.signOut)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .redacted(reason: store.user == .placeholder ? .placeholder : [])
            
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .onAppear {
            store.send(.viewOnAppear)
        }
    }
}

struct SettingsCell: View {
    var title: LocalizedStringResource
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(title)
                
                Spacer()
                
                Image(systemName: SFSymbols.chevronRight.rawValue)
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
