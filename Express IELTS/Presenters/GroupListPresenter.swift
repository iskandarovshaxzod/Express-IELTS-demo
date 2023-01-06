//
//  GroupListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 03.01.2023.
//

import Foundation
import UIKit

class GroupListPresenter {
    
    typealias PresenterDelegate = GroupListDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllTeachers(teacherName: String, configName: String) {
        FirebaseManager.shared.getAllGroups(teacherName: teacherName, configName: configName) { [weak self] groups in
            self?.delegate?.onSuccessGetAllGroups(groups: groups)
        } error: { [weak self] err in
            self?.delegate?.onErrorGetAllGroups(error: err)
        }
    }
}

