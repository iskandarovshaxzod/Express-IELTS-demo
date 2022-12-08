//
//  FirebaseManager.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


struct FirebaseManager{
    
    let db = Firestore.firestore()
    
    
    
    static func addNewBranch(){
        Auth.auth().createUser(withEmail: "", password: "") { res, err in
            if err != nil {
                // show error
            } else {
                
            }
        }
    }
    
    static func validateUser(email: String, password: String) -> String? {
        var error: String?
        Auth.auth().signIn(withEmail: email, password: password) { res, err in
            error = err?.localizedDescription
        }
        return error
    }
    
    static func changePassword(){
        Auth.auth().currentUser?.updatePassword(to: ""){ (error) in
            
        }
        
//        Auth.auth().
    }
    
    static func showError(){
        
    }
    
}
