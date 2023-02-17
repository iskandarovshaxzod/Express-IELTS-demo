//
//  BranchPaymentListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 07.01.2023.
//

import Foundation

protocol TeacherPaymentListDelegate {
    func onSuccessGetAllTeacherPayments(payments: [TeacherPayments], allReceipts: [Payment])
    func onSuccessAddNewTeacherPayment()
    func onError(error: String?)
}
