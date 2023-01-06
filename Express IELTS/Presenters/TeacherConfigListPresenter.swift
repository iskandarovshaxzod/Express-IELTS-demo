//
//  TeacherConfigListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation
import UIKit

class TeacherConfigListPresenter {
    
    typealias PresenterDelegate = TeacherConfigListDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllTeachers(teacherName: String) {
        FirebaseManager.shared.getAllTeacherConfigs(teacherName: teacherName) { [weak self] groups in
            self?.delegate?.onSuccessGetAllTeacherConfigs(configs: groups)
        } error: { [weak self] err in
            self?.delegate?.onErrorGetAllTeacherConfigs(error: err)
        }
    }
}
