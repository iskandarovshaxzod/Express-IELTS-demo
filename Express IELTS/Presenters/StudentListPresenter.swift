//
//  StudentListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation
import UIKit

class StudentListPresenter {
    
    typealias PresenterDelegate = StudentListDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllStudents() {
        FirebaseManager.shared.getAllStudentsOfGroup() { [weak self] students in
            self?.delegate?.onSuccessGetAllStudents(students: students)
        } error: { [weak self] err in
            self?.delegate?.onErrorGetAllStudents(error: err)
        }
    }
}

