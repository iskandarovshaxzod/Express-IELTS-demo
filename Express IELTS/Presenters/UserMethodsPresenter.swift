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
        FirebaseManager.shared.validateUser(email: email, password: password) { [weak self] in
            self?.delegate?.onSuccessValidateUser()
        } error: { [weak self] err in
            self?.delegate?.onErrorValidateUser(error: err?.localizedDescription)
        }
    }
    
    func changePassword(email: String, password: String) {
        FirebaseManager.shared.changePassword(for: email, password: password) { [weak self] in
            self?.delegate?.onSuccessChangePassword()
        } error: { [weak self] err in
            self?.delegate?.onErrorChangePassword(error: err?.localizedDescription)
        }
    }
}
