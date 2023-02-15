//
//  TeacherListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation

protocol TeacherListDelegate {
    func onSuccessGetAllTeachers(teachers: [Teacher])
    func onSuccessUpdateTeacher()
    func onSuccessDeleteTeacher()
    func onError(error: String?)
}
