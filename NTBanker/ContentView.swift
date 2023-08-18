//
//  ContentView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<AppReducer>
    
    var body: some View {
        WithViewStore(self.store, observe: \.route) { viewStore in
            Group {
                switch viewStore.state {
                case .empty:
                    EmptyView()
                case .welcome:
                    WelcomeView(
                        store: store.scope(
                            state: \.auth,
                            action: AppReducer.Action.auth
                        )
                    )
                case .home:
                    HomeTabView()
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#Preview {
    ContentView(
        store: Store(initialState: AppReducer.State()) {
            AppReducer()
        }
    )
}
