//
//  LoginView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import SwiftUI

struct LoginView: View {
    @State private var emailQuery = ""
    @State private var passwordQuery = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NTLogoHeaderView()
                    .padding(.top, 20)
                
                Text("Log in to your account")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 10)
                
                
                VStack(spacing: 10) {
                    Group {
                        TextField("Email", text: $emailQuery)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                        
                        SecureField("Password", text: $passwordQuery)
                    }
                    .textFieldStyle(NTTextfieldStyle())
                    
                    NTButton(title: "Login") {
                        print("Login button tapped")
                    }
                }
                .padding()
                
                Divider()
                
                Button("Forgot your password?") {
                    
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
