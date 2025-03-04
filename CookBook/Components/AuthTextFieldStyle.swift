//
//  AuthTextFieldStyle.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import SwiftUI

struct AuthTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            configuration
                .font(.system(size: 14))
                .textInputAutocapitalization(.never)
            Rectangle()
                .fill(.border)
                .frame(height: 1)
                .padding(.bottom, 15)
        }
    }
    
    
}
