//
//  NTTextfieldStyle.swift
//  NTBanker
//
//  Created by Javier Munoz on 8/1/23.
//

import SwiftUI

struct NTTextfieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 50)
            .padding(.horizontal)
            .background {
                Color(uiColor: .secondarySystemBackground)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Preview
private struct NTTextfieldTestView: View {
    @State private var query = ""
    
    var body: some View {
        TextField("Hello, World!", text: $query)
            .textFieldStyle(NTTextfieldStyle())
    }
}

#Preview {
    NTTextfieldTestView()
}
