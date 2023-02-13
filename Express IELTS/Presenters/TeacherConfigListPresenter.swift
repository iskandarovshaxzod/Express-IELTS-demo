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
    let body: Config? = nil
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllTeacherConfigs(teacherID: String) {
        let url = URL(string: Constants.BASE_URL + Constants.CONFIG_LIST + teacherID)!
        APIManager.shared.performRequest(url: url, method: .get, body: body, parameters: nil) {
            [weak self] (result: Result<[Config], Error>) in
            switch result {
            case .success(let configs):
                self?.delegate?.onSuccessGetAllTeacherConfigs(configs: configs)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func deleteConfig(configID: String) {
        let url = URL(string: Constants.BASE_URL + Constants.CONFIG_DELETE + configID)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .delete, body: body, parameters: nil) {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.onSuccessDeleteConfig()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
}
