//
//  AddMethodsDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.01.2023.
//

import Foundation

protocol AddMethodsDelegate {
    func onSuccessAddNewTeacher()
    func onSuccessAddNewTeacherConfig()
    func onSuccessAddNewGroup()
    func onSuccessAddNewStudent()
    func onErrorAddNew(error: String?)
}
