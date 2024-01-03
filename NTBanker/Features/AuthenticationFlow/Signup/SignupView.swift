//
//  SignupView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import SwiftUI

struct SignupView: View {
    @Bindable var store: StoreOf<SignupFeature>
    
    var body: some View {
        ScrollView {
            NTLogoHeaderView()
                .padding(.top, 20)
            
            Text("Create an account")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 10)
            
            VStack(spacing: 10) {
                TextField("Name", text: $store.name)
                
                TextField("Email", text: $store.email)
                    .keyboardType(.emailAddress)
                
                NTCardColorPickerView(selectedColor: $store.selectedCardColor)
                
                SecureField("Password", text: $store.passwordQuery)
                
                SecureField("Confirm Password", text: $store.confirmPasswordQuery)
                
                NTLoadingButton(title: "Sign Up", isLoading: store.isLoading) {
                    store.send(.createButtonTapped)
                }
                .disabled(store.shouldDisableLoginButton)
            }
            .textFieldStyle(NTTextfieldStyle())
            .padding()
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    SignupView(
        store: Store(initialState: SignupFeature.State()) {
            SignupFeature()
        }
    )
}
