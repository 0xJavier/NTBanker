//
//  AppScreen.swift
//  NTBanker
//
//  Created by Javier Munoz on 1/2/24.
//

import ComposableArchitecture
import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case home
    case lotteryView
    case rankingView
    case settingsView
    
    var id: AppScreen { self }
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            Label("Home", systemImage: SFSymbols.house.rawValue)
        case .lotteryView:
            Label("Lottery", systemImage: SFSymbols.dollarSignSquare.rawValue)
        case .rankingView:
            Label("Ranking", systemImage: SFSymbols.personGroup.rawValue)
        case .settingsView:
            Label("Settings", systemImage: SFSymbols.gear.rawValue)
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .home:
            HomeView(
                store: Store(initialState: HomeFeature.State()) {
                    HomeFeature()
                }
            )

        case .lotteryView:
            LotteryView(
                store: Store(initialState: LotteryFeature.State()) {
                    LotteryFeature()
                }
            )

        case .rankingView:
            RankingView(
                store: Store(initialState: RankingFeature.State()) {
                    RankingFeature()
                }
            )

        case .settingsView:
            SettingsView(
                store: Store(initialState: SettingsFeature.State()) {
                    SettingsFeature()
                }
            )
        }
    }
}
