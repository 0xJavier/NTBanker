//
//  ContentView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import FirebaseAuth
import SwiftUI

struct ContentView: View {
    var isLoggedIn: Bool {
        Auth.auth().currentUser?.uid != nil
    }
    
    var body: some View {
        if isLoggedIn {
            HomeTabView()
        } else {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}
