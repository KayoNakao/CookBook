//
//  SessionManager.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import Foundation
import FirebaseAuth
import FirebaseCore

@Observable
class SessionManager {
    
    var sessionState: SessionState = .loggedOut
    var user: User?
    
    init() {
        if FirebaseApp.allApps == nil {
            FirebaseApp.configure()
        }
        sessionState = Auth.auth().currentUser != nil ? .loggedIn : .loggedOut
    } 
}
