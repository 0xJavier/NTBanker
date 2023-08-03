//
//  LoginView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import SwiftUI

struct LoginView: View {
    let store: StoreOf<LoginFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                NTLogoHeaderView()
                    .padding(.top, 20)
                
                Text("Log in to your account")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 10)
                
                
                VStack(spacing: 10) {
                    Group {
                        TextField("Email", text: viewStore.$emailQuery)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                        
                        SecureField("Password", text: viewStore.$passwordQuery)
                    }
                    .textFieldStyle(NTTextfieldStyle())

                    
                    
                    Button(action: {
                        viewStore.send(.loginButtonTapped)
                    }, label: {
                        if viewStore.isLoading {
                            ProgressView()
                                .tint(.primary)
                                .controlSize(.regular)
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                        }
                    })
                    .disabled(viewStore.shouldDisableLoginButton)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .controlSize(.large)
                }
                .padding()
                
                Divider()
                
                Button("Forgot your password?") {
                    viewStore.send(.forgotPasswordButtonTapped)
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView(
        store: Store(initialState: LoginFeature.State()) {
            LoginFeature()
        }
    )
}
