//
//  HomeViewModel.swift
//  CookBook
//
//  Created by Kayo on 2025-03-04.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class HomeViewModel {
    
    var showSignOutAlert = false
    var showAddReceipeView = false
    var receipes: [Receipe] = []
    
    func fetchReceipes() async {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        do {
            let receipesResult = try await Firestore.firestore().collection("receipes").whereField("userId", isEqualTo: userId).getDocuments()
            receipes = receipesResult.documents.compactMap({ Receipe(snapshot: $0)})
        } catch {
            print(error.localizedDescription)
        }
    }
    
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
