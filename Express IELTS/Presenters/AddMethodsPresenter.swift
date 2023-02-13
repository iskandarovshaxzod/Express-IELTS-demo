//
//  AddMethodsPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.01.2023.
//

import UIKit

class AddMethodsPresenter {
    typealias PresenterDelegate = AddMethodsDelegate & UIViewController
    
    let body: Branch? = nil
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func addBranch(stringURL: String, body: Branch) {
        let url = URL(string: stringURL)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .post, body: body, parameters: nil) {
            [weak self] response in
            switch response{
            case .success(let response):
                self?.delegate?.onSuccessAddNew()
            case .failure(let error):
                self?.delegate?.onErrorAddNew(error: error.localizedDescription)
            }
        }
    }
    
    func addTeacher(stringURL: String, body: Teacher) {
        let url = URL(string: stringURL)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .post, body: body, parameters: nil) {
            [weak self] response in
            switch response{
            case .success(let response):
                self?.delegate?.onSuccessAddNew()
            case .failure(let error):
                self?.delegate?.onErrorAddNew(error: error.localizedDescription)
            }
        }
    }
    
    func addTeacherConfig(stringURL: String, body: Config) {
        let url = URL(string: stringURL)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .post, body: body, parameters: nil) {
            [weak self] response in
            switch response{
            case .success(let response):
                self?.delegate?.onSuccessAddNew()
            case .failure(let error):
                self?.delegate?.onErrorAddNew(error: error.localizedDescription)
            }
        }
    }
    
    func addGroup(stringURL: String, body: Group) {
        let url = URL(string: stringURL)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .post, body: body, parameters: nil) {
            [weak self] response in
            switch response{
            case .success(let response):
                self?.delegate?.onSuccessAddNew()
            case .failure(let error):
                self?.delegate?.onErrorAddNew(error: error.localizedDescription)
            }
        }
    }
    
    func addStudent(stringURL: String, body: Student) {
        let url = URL(string: stringURL)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .post, body: body, parameters: nil) {
            [weak self] response in
            switch response{
            case .success(let response):
                self?.delegate?.onSuccessAddNew()
            case .failure(let error):
                self?.delegate?.onErrorAddNew(error: error.localizedDescription)
            }
        }
    }
    
}
