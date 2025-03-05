//
//  HomeViewModel.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import Foundation
import FirebaseAuth

@Observable
class HomeViewModel {
    
    var showSignOutAlert = false
    var showAddReceipeView = false
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
