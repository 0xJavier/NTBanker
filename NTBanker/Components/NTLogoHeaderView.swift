//
//  NTLogoHeaderView.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import SwiftUI

struct NTLogoHeaderView: View {
    var body: some View {
        HStack {
            Image(.miniLogo)
            Text("NTBanker")
        }
        .frame(width: 115, height: 28)
    }
}

#Preview {
    NTLogoHeaderView()
}
