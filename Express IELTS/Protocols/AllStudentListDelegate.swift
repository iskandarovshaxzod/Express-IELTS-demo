//
//  AllStudentListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.01.2023.
//

import Foundation

protocol AllStudentListDelegate {
    func onSuccessGetAllStudents(students: [String])
    func onErrorGetAllStudents(error: String?)
}
