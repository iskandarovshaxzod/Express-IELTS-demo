//
//  TeacherListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation
import UIKit

class TeacherListPresenter {
    
    typealias PresenterDelegate = TeacherListDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllTeachers() {
        FirebaseManager.shared.getAllTeachers(success: { [weak self] teachers in
            self?.delegate?.onSuccessGetAllTeachers(teachers: teachers)
        }, error: { [weak self] err in
            self?.delegate?.onErrorGetAllTeachers(error: err)
        })
    }
}
