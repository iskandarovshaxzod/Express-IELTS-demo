//
//  UserMethodsPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.01.2023.
//

import UIKit
 
class UserMethodsPresenter {
    
    typealias PresenterDelegate = UserMethodsDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    let body: User? = nil
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func validateUser(login: String, password: String) {
        let url  = URL(string: Constants.BASE_URL + Constants.USER_AUTH)!
        let user = User(login: login, password: password)
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .post, body: user, parameters: nil) { [weak self] response in
            switch response{
            case .success(let res):
                self?.delegate?.onSuccessValidateUser()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func changePassword(login: String, password: String, userID: String) {
        let url  = URL(string: Constants.BASE_URL + Constants.USER_CHANGE_PASS + userID)!
        let user = User(login: login, password: password)
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .put, body: user, parameters: nil) {
            [weak self] result in
            switch result{
            case .success(let response):
                self?.delegate?.onSuccessChangePassword()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func getAllUsers() {
        let url  = URL(string: Constants.BASE_URL + Constants.USER_LIST)!
        APIManager.shared.performRequest(url: url, method: .get, body: body, parameters: nil) {
            [weak self] (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                var sortedUsers: [[User]] = [[], []]
                users.forEach { user in
                    if user.login == "admin" {
                        sortedUsers[0].append(user)
                    } else {
                        sortedUsers[1].append(user)
                    }
                }
                self?.delegate?.onSuccessGetAllUsers(users: sortedUsers)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
}
