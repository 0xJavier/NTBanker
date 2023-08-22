//
//  WelcomeView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import SwiftUI

struct WelcomeView: View {
    let store: StoreOf<AuthenticationFeature>
    
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
                        NavigationLink {
                            LoginView(
                                store: store.scope(
                                    state: \.login,
                                    action: AuthenticationFeature.Action.login
                                )
                            )
                        } label: {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                        }
                        
                        NavigationLink {
                            SignupView(
                                store: store.scope(
                                    state: \.signup,
                                    action: AuthenticationFeature.Action.signup
                                )
                            )
                        } label: {
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
            Image(systemName: SFSymbols.dollarSignCircle.rawValue)
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text(welcomeString)
            
            Text("Welcome to NTBanker. Speed up game banking with our easy to use Balance cards.")
                .font(.system(size: 20, weight: .bold))
        }
    }
}

extension WelcomeView {
    private var welcomeString: AttributedString {
        var enhanceAttributedString = AttributedString(localized: "Enhance ")
        enhanceAttributedString.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        enhanceAttributedString.foregroundColor = .label
        
        var familyAttributedString = AttributedString(localized: "Family Game Nights")
        familyAttributedString.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        familyAttributedString.foregroundColor = .blue
                
        return enhanceAttributedString + familyAttributedString
    }
}

#Preview {
    WelcomeView(
        store: Store(initialState: AuthenticationFeature.State()) {
            AuthenticationFeature()
        }
    )
}
