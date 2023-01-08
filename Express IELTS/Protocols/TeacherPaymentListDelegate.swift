//
//  BranchPaymentListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.01.2023.
//

import Foundation

protocol TeacherPaymentListDelegate {
    func onSuccessGetAllPayment(receipts: [ReceiptModel])
    func onErrorGetAllStudents(error: String?)
}
