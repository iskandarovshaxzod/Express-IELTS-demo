//
//  AddMethodsDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.01.2023.
//

import Foundation

protocol AddMethodsDelegate {
    func onSuccessAddNew()
    func onErrorAddNew(error: String?)
}
