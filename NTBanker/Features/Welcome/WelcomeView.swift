//
//  WelcomeView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import SwiftUI

struct WelcomeView: View {
    private var welcomeString: AttributedString {
        var attributedString = AttributedString("Enhance Family Game Nights")
        attributedString.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        attributedString.foregroundColor = .black
        
        if let range = attributedString.range(of: "Family Game Nights") {
            attributedString[range].foregroundColor = .blue
        }
        
        return attributedString
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    headerView
                    
                    Spacer()
                        .frame(height: 125)
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: loginView) {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                        }
                        
                        NavigationLink(destination: signupView) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .controlSize(.large)
                }
                .padding()
            }
        }
    }
    
    var headerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: SFSymbols.dollarSignCircle.imageString)
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text(welcomeString)
            
            Text("Welcome to NTBank. Speed up game banking with our easy to use Balance cards.")
                .font(.system(size: 20, weight: .bold))
        }
    }
    
    var loginView: some View {
        LoginView(
            store: Store(initialState: LoginFeature.State()) {
                LoginFeature()
            }
        )
    }
    
    var signupView: some View {
        SignupView(
            store: Store(initialState: SignupFeature.State()) {
                SignupFeature()
            }
        )
    }
}

#Preview {
    WelcomeView()
}
