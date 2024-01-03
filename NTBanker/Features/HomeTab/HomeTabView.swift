//
//  HomeTabView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/8/23.
//

import SwiftUI

struct HomeTabView: View {
    @State private var selection: AppScreen = .home
    
    var body: some View {
        TabView(selection: $selection) {
            Group {
                ForEach(AppScreen.allCases) { screen in
                    screen.destination
                        .tag(screen as AppScreen?)
                        .tabItem { screen.label }
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
