//
//  AddMethodsPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.01.2023.
//

import UIKit

class AddMethodsPresenter {
    typealias PresenterDelegate = AddMethodsDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func addNewTeacher(teacherName: String) {
        FirebaseManager.shared.addNewTeacher(teacherName: teacherName, success: { [weak self] in
            self?.delegate?.onSuccessAddNewTeacher()
        }, error: { [weak self] err in
            self?.delegate?.onErrorAddNew(error: err?.localizedDescription)
        })
    }
    
    func addNewTeacherConfig(configName: String) {
        FirebaseManager.shared.addNewTeacherConfig(configName: configName, success: { [weak self] in
            self?.delegate?.onSuccessAddNewTeacherConfig()
        }, error: { [weak self] err in
            self?.delegate?.onErrorAddNew(error: err?.localizedDescription)
        })
    }
    
    func addNewGroup(groupName: String, groupType: GroupType) {
        FirebaseManager.shared.addNewGroup(groupName: groupName, groupType: groupType,
        success: { [weak self] in
            self?.delegate?.onSuccessAddNewGroup()
        }, error: { [weak self] err in
            self?.delegate?.onErrorAddNew(error: err?.localizedDescription)
        })
    }
    
    func addNewStudent(studentName: String) {
        FirebaseManager.shared.addNewStudent(studentName: studentName, success: { [weak self] in
            self?.delegate?.onSuccessAddNewStudent()
        }, error: { [weak self] err in
            self?.delegate?.onErrorAddNew(error: err?.localizedDescription)
        })
    }
}
