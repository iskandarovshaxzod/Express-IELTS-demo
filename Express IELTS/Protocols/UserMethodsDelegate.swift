//
//  UserMethodsDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.01.2023.
//

import Foundation

protocol UserMethodsDelegate {
    func onSuccessValidateUser()
    func onErrorValidateUser(error: String?)
    func onSuccessChangePassword()
    func onErrorChangePassword(error: String?)
}
