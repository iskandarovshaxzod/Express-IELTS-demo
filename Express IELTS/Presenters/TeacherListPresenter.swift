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
    let body:Teacher? = nil
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllTeachers(branchID: String) {
        let url = URL(string: Constants.BASE_URL + Constants.TEACHER_LIST + branchID)!
        APIManager.shared.performRequest(url: url, method: .get, body: body, parameters: nil) { [weak self]
            (result: Result<[Teacher], Error>) in
            switch result {
            case .success(let teachers):
                self?.delegate?.onSuccessGetAllTeachers(teachers: teachers)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func deleteTeacher(teacherID: String) {
        let url = URL(string: Constants.BASE_URL + Constants.TEACHER_DELETE + teacherID)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .delete, body: body, parameters: nil) {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.onSuccessDeleteTeacher()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
}
