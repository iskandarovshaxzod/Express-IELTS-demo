//
//  AllStudentListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.01.2023.
//

import UIKit

class AllStudentListPresenter {
    typealias PresenterDelegate = AllStudentListDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllStudents(monthName: String) {
        FirebaseManager.shared.getAllStudentsOfBranch(monthName: monthName) { [weak self] students in
            self?.delegate?.onSuccessGetAllStudents(students: students)
        } error: { [weak self] err in
            self?.delegate?.onErrorGetAllStudents(error: err)
        }
    }
}
