//
//  StudentListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation

protocol StudentListDelegate {
    func onSuccessGetAllStudents(students: [StudentCheckModel])
    func onErrorGetAllStudents(error: String?)
}
