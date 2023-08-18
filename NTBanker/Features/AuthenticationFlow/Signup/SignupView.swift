//
//  SignupView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import ComposableArchitecture
import SwiftUI

struct SignupView: View {
    let store: StoreOf<SignupFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                NTLogoHeaderView()
                    .padding(.top, 20)
                
                Text("Create an account")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 10)
                
                VStack(spacing: 10) {
                    TextField("Name", text: viewStore.$name)
                    
                    TextField("Email", text: viewStore.$email)
                        .keyboardType(.emailAddress)
                    
                    NTCardColorPickerView(selectedColor: viewStore.$selectedCardColor)
                    
                    SecureField("Password", text: viewStore.$passwordQuery)
                    
                    SecureField("Confirm Password", text: viewStore.$confirmPasswordQuery)
                    
                    NTLoadingButton(title: "Sign Up", isLoading: viewStore.isLoading) {
                        viewStore.send(.createButtonTapped)
                    }
                    .disabled(viewStore.shouldDisableLoginButton)
                }
                .textFieldStyle(NTTextfieldStyle())
                .padding()
            }
        }
    }
}

#Preview {
    SignupView(
        store: Store(initialState: SignupFeature.State()) {
            SignupFeature()
        }
    )
}
