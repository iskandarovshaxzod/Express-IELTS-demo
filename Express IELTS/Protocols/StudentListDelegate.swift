//
//  StudentListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation

protocol StudentListDelegate {
    func onSuccessGetAllBranchStudents(students: [Student])
    func onSuccessDeleteStudent()
    func onError(error: String?)
}
