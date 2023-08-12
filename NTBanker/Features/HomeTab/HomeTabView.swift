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
    init() {
        UITabBar.appearance().backgroundColor = .systemTeal
    }
    
    var body: some View {
        TabView {
            Group {
                HomeView(
                    store: Store(initialState: HomeFeature.State()) {
                        HomeFeature()
                    }
                )
                .tabItem {
                    Label("Home", systemImage: SFSymbols.house.imageString)
                }
                
                LotteryView(
                    store: Store(initialState: LotteryFeature.State()) {
                        LotteryFeature()
                    }
                )
                .tabItem {
                    Label("Lottery", systemImage: SFSymbols.dollarSignSquare.imageString)
                }
                
                RankingView(
                    store: Store(initialState: RankingFeature.State()) {
                        RankingFeature()
                    }
                )
                .tabItem {
                    Label("Ranking", systemImage: SFSymbols.personGroup.imageString)
                }
                
                Text("Settings")
                    .tabItem {
                        Label("Settings", systemImage: SFSymbols.gear.imageString)
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