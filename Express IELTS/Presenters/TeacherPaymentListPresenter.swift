//
//  BranchPaymentListPresenter.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.01.2023.
//

import UIKit

class TeacherPaymentListPresenter {
    
    typealias PresenterDelegate = TeacherPaymentListDelegate & UIViewController
    
    weak var delegate: PresenterDelegate?
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllPayments(monthName: String) {
        FirebaseManager.shared.getAllReceipts(monthName: monthName) { [weak self] receipts in
            self?.delegate?.onSuccessGetAllPayment(receipts: receipts)
        } error: { [weak self] err in
            self?.delegate?.onErrorGetAllStudents(error: err)
        }
    }
}
