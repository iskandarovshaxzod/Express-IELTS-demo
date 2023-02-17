//
//  BranchPaymentListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.01.2023.
//

import UIKit

class TeacherPaymentListPresenter {
    
    typealias PresenterDelegate = TeacherPaymentListDelegate & UIViewController
    
    var body: Payment? = nil
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func addTeacherPayment(payment: Payment) {
        let url = URL(string: Constants.BASE_URL + Constants.PAYMENT_ADD)!
        APIManager.shared.performRequestWithHTTPResponse(url: url, method: .post, body: payment, parameters: nil) {
            [weak self] result in
            switch result {
            case .success(let responsse):
                self?.delegate?.onSuccessAddNewTeacherPayment()
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
    
    func getAllTeacherPayments(teacherID: String, year: Int, month: Int) {
        let url = URL(string: Constants.BASE_URL + Constants.PAYMENT_TEACHER_LIST + teacherID)!
        let date = DateTime(year: year, month: month)
        APIManager.shared.performRequest(url: url, method: .post, body: date, parameters: nil) {
        [weak self] (result: Result<[TeacherPayments], Error>) in
            switch result {
            case .success(let payments):
                var receipts = [Payment]()
                for payment in payments {
                    receipts += payment.payments
                }
                self?.delegate?.onSuccessGetAllTeacherPayments(payments: payments, allReceipts: receipts)
            case .failure(let error):
                self?.delegate?.onError(error: error.localizedDescription)
            }
        }
    }
}
