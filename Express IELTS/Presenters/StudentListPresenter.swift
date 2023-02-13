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
    
    var body: Student? = nil
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllGroupStudents(groupID: String, year: Int, month: Int) {
        let url = URL(string: Constants.BASE_URL + Constants.STUDENT_GROUP_LIST + groupID)!
        let date = DateTime(year: year, month: month)
        APIManager.shared.performRequest(url: url, method: .post, body: date, parameters: nil) {
            [weak self] (result: Result<[StudentWithAttendance], Error>) in
            switch result {
            case .success(let students):
                self?.delegate?.onSuccessGetAllGroupStudents(students: students)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func getAllBranchStudents(branchID: String, year: Int, month: Int) {
        let url = URL(string: Constants.BASE_URL + Constants.STUDENT_BRANCH_LIST + branchID)!
        let date = DateTime(year: year, month: month)
        APIManager.shared.performRequest(url: url, method: .post, body: date, parameters: nil) {
            [weak self] (result: Result<[Student], Error>) in
            switch result {
            case .success(let students):
                self?.delegate?.onSuccessGetAllBranchStudents(students: students)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func deleteStudent(studentID: String) {
        let url = URL(string: Constants.BASE_URL + Constants.STUDENT_DELETE + studentID)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .delete, body: body, parameters: nil) {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.onSuccessDeleteStudent()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
}

