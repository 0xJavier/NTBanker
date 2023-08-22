//
//  HomeTabView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import ComposableArchitecture
import FirebaseAuth
import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            Group {
                HomeView(
                    store: Store(initialState: HomeFeature.State()) {
                        HomeFeature()
                    }
                )
                .tabItem {
                    Label("Home", systemImage: SFSymbols.house.rawValue)
                }
                
                LotteryView(
                    store: Store(initialState: LotteryFeature.State()) {
                        LotteryFeature()
                    }
                )
                .tabItem {
                    Label("Lottery", systemImage: SFSymbols.dollarSignSquare.rawValue)
                }
                
                RankingView(
                    store: Store(initialState: RankingFeature.State()) {
                        RankingFeature()
                    }
                )
                .tabItem {
                    Label("Ranking", systemImage: SFSymbols.personGroup.rawValue)
                }
                
                SettingsView(
                    store: Store(initialState: SettingsFeature.State()) {
                        SettingsFeature()
                    }
                )
                .tabItem {
                    Label("Settings", systemImage: SFSymbols.gear.rawValue)
                }
            }
            .toolbarBackground(Color(uiColor: .systemBackground), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    HomeTabView()
}
