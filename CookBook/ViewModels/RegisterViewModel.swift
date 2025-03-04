//
//  RegisterViewModel.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class RegisterViewModel {
    
    var username = ""
    var email = ""
    var password = ""
    var showPassword = false
    var isLoading = false
    var errorMessage = ""
    var presentAlert = false
    
    func signup() async -> Bool {
        
        guard validateUsername() else {
            errorMessage = "Username must be greater than 3 characters and less than 25 characters."
            presentAlert = true
            return false
        }
        
        isLoading = true

        guard let usernameDocuments = try? await Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments() else {
            isLoading = false
            errorMessage = "Something has gone wrong. Please try again later."
            presentAlert = true
            return false
        }
        
        guard usernameDocuments.documents.count == 0 else {
            isLoading = false
            errorMessage = "Username already exsits"
            presentAlert = true
            return false
        }
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let userData: [String: Any] = [
                "username": username,
                "email": email
            ]
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(userData)
            isLoading = false
            return true
        } catch {
            errorMessage = "Login Failed"
            if let errorCode = AuthErrorCode(rawValue: error._code) {
                switch errorCode {
                case .emailAlreadyInUse:
                    errorMessage = "Email Already In Use"
                case .invalidEmail:
                    errorMessage = "Invalid Email"
                default:
                    break
                }
            }
            isLoading = false
            presentAlert = true
            return false
        }
     }

    func validateUsername() -> Bool {
        username.count >= 3 && username.count < 25
    }
 
}
