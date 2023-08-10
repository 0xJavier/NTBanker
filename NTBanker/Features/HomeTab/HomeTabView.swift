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
    }
}

#Preview {
    HomeTabView()
}
