//
//  MonthListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 15.02.2023.
//

import Foundation
import UIKit

class MonthListPresenter {
    typealias PresenterDelegate = MonthListDelegate & UIViewController
    
    var body: Months? = nil
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllMonths() {
        let url = URL(string: Constants.BASE_URL + Constants.MONTH_LIST)!
        APIManager.shared.performRequest(url: url, method: .get, body: body, parameters: nil) {
            [weak self] (result: Result<[Months], Error>) in
            switch result {
            case .success(let months):
                self?.delegate?.onSuccessGetAllMonths(months: months)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
}
