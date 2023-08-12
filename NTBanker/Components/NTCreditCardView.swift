//
//  NTCreditCardView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/5/23.
//

import SwiftUI

struct NTCreditCardView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            NTLogoHeaderView()
            
            Spacer()
            
            HStack(alignment: .bottom) {
                balanceView
                Spacer()
                Text(user.name)
                    .font(.title2)
                    .bold()
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(width: 343, height: 192)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(user.colorLiteral)
                .shadow(radius: 10)
        )
    }
    
    var balanceView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Balance:")
            Text("$\(user.balance)")
                .font(.title)
                .bold()
        }
    }
}

#Preview {
    NTCreditCardView(user: User.placeholder)
}
