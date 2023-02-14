//
//  UserMethodsDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.01.2023.
//

import Foundation

protocol UserMethodsDelegate {
    func onSuccessValidateUser()
    func onSuccessChangePassword()
    func onSuccessGetAllUsers(users: [[User]])
    func onError(error: String?)
}
