//
//  UserMethodsPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.01.2023.
//

import UIKit
 
class UserMethodsPresenter {
    
    typealias PresenterDelegate = UserMethodsDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func validateUser(email: String, password: String) {
        
    }
    
    func changePassword(email: String, password: String) {
        
    }
}
