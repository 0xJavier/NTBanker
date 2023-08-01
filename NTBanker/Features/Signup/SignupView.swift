//
//  SignupView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import SwiftUI

enum CardColor: String, CaseIterable {
    case red, blue, green, pink, purple, orange
}

struct SignupView: View {
    @State private var nameQuery = ""
    @State private var emailQuery = ""
    @State private var selectedCardColor: CardColor = .blue
    @State private var passwordQuery = ""
    @State private var confirmPasswordQuery = ""
    
    var body: some View {
        ScrollView {
            NTLogoHeaderView()
                .padding(.top, 20)
            
            Text("Create an account")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 10)
            
            VStack(spacing: 10) {
                TextField("Name", text: $nameQuery)
                
                TextField("Email", text: $emailQuery)
                
                cardColorPickerView
                
                SecureField("Password", text: $passwordQuery)
                
                SecureField("Confirm Password", text: $confirmPasswordQuery)
                
                NTButton(title: "Create") {
                    print("Create Button Tapped")
                }
            }
            .textFieldStyle(NTTextfieldStyle())
            .padding()
        }
    }
    
    var cardColorPickerView: some View {
        HStack {
            Text("Card Color")
            
            Spacer()
            
            Picker("Card Color", selection: $selectedCardColor) {
                ForEach(CardColor.allCases, id: \.self) {
                    Text($0.rawValue.capitalized)
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(uiColor: .secondarySystemBackground))
        }
    }
}

#Preview {
    SignupView()
}
