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
    
    let body: Group? = nil
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllGroups(configID: String) {
        let url = URL(string: Constants.BASE_URL + Constants.GROUP_LIST + configID)!
        APIManager.shared.performRequest(url: url, method: .get, body: body, parameters: nil) { [weak self]
            (result: Result<[Group], Error>) in
            switch result {
            case .success(let groups):
                self?.delegate?.onSuccessGetAllGroups(groups: groups)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func deleteGroup(groupID: String) {
        let url = URL(string: Constants.BASE_URL + Constants.GROUP_DELETE + groupID)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .delete, body: body, parameters: nil) {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.onSuccesDeleteGroup()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
}

