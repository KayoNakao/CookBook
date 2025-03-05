//
//  LoginViewModel.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class LoginViewModel {
    
    var presentRegisterView = false
    var email = ""
    var password = ""
    var showPassword = false
    var errorMessage = ""
    var presentAlert = false
    var isLoading = false
    
    func login() async -> User? {
        isLoading = true
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let user  = try await Firestore.firestore().collection("users").document(result.user.uid).getDocument(as: User.self)
            isLoading = false
            return user
        } catch {
            isLoading = false
            errorMessage = "Login Failed"
            if let errorCode = AuthErrorCode(rawValue: error._code) {
                switch errorCode {
                case .wrongPassword:
                    errorMessage = "Wrong Password"
                case .invalidEmail:
                    errorMessage = "Invalid Email"
                default:
                    break
                }
            }
            presentAlert = true
            return nil
        }
    }
}
