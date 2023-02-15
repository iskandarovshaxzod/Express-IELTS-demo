//
//  BranchesListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 02.01.2023.
//

import UIKit

class BranchListPresenter {

    typealias PresenterDelegate = BranchListDelegate & UIViewController
    let body: Branch? = nil
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllBranches() {
        let url = URL(string: Constants.BASE_URL + Constants.BRANCH_LIST)!
        APIManager.shared.performRequest(url: url, method: .get, body: body, parameters: nil) { [weak self]
            (result: Result<[Branch], Error>) in
            switch result {
            case .success(let branches):
                self?.delegate?.onSuccessGetAllBranches(branches: branches)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
//    func addNewBranch(name: String, password: String) {
//        let url = URL(string: Constants.BASE_URL + Constants.BRANCH_ADD)!
//        let branch = Branch(id: nil, branchName: name, password: password, isValid: true)
//        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .post, body: branch, parameters: nil) { [weak self] result in
//            switch result {
//            case .success(let response):
//                self?.delegate?.onSuccessGetAllBranches(branches: [])
//            case .failure(let error):
//                self?.delegate?.onError(error: error.localizedDescription)
//            }
//        }
//    }
    
    func updateBranch(branchID: String, login: String) {
        let url = URL(string: Constants.BASE_URL + Constants.USER_CHANGE_NAME + branchID)!
        let branch = User(login: login, password: "12345")
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .put, body: branch, parameters: nil) {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.onSuccessUpdateBranch()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func deleteBranch(branchID: String) {
        let url = URL(string: Constants.BASE_URL + Constants.BRANCH_DELETE + branchID)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .delete, body: body, parameters: nil) {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.onSuccessDeleteBranch()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
}
