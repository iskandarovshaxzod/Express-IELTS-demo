//
//  StudentListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation

protocol StudentListDelegate {
    func onSuccessGetAllGroupStudents(students: [StudentWithAttendance])
    func onSuccessGetAllBranchStudents(students: [Student])
    func onSuccessPayForStudent()
    func onSuccessUpdateStudent()
    func onSuccessDeleteStudent()
    func onError(error: String?)
}
