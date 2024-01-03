//
//  LoginView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import SwiftUI

struct LoginView: View {
    @Bindable var store: StoreOf<LoginFeature>
    
    var body: some View {
        VStack {
            NTLogoHeaderView()
                .padding(.top, 20)
            
            Text("Log in to your account")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 10)
            
            
            VStack(spacing: 10) {
                Group {
                    TextField("Email", text: $store.emailQuery)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                    
                    SecureField("Password", text: $store.passwordQuery)
                }
                .textFieldStyle(NTTextfieldStyle())
                
                NTLoadingButton(title: "Login", isLoading: store.isLoading) {
                    store.send(.loginButtonTapped)
                }
                .disabled(store.shouldDisableLoginButton)
            }
            .padding()
            
            Divider()
            
            Button("Forgot your password?") {
                store.send(.forgotPasswordButtonTapped)
            }
            .padding()
            
            Spacer()
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    LoginView(
        store: Store(initialState: LoginFeature.State()) {
            LoginFeature()
        }
    )
}
