//
//  PasswordComponentView.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import SwiftUI

struct PasswordComponentView: View {
    
    @Binding var showPassword: Bool
    @Binding var password: String
    
    var body: some View {
        if showPassword {
            TextField("Password", text: $password)
                .keyboardType(.emailAddress)
                .textFieldStyle(AuthTextFieldStyle())
                .overlay(alignment: .trailing) {
                    Button(action: {
                        showPassword = false
                    }, label: {
                        Image(systemName: "eye")
                            .foregroundStyle(.black)
                            .padding(.bottom)
                    })
                }
        } else {
            VStack {
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                Rectangle()
                    .fill(.border)
                    .frame(height: 1)
                    .padding(.bottom, 15)
            }
            .overlay(alignment: .trailing) {
                Button(action: {
                    showPassword = true
                }, label: {
                    Image(systemName: "eye.slash")
                        .foregroundStyle(.black)
                        .padding(.bottom)
                })
            }
        }
    }
}

#Preview {
    PasswordComponentView(showPassword: .constant(false), password: .constant(""))
}
