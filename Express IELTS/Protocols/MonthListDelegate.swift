//
//  MonthListDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 15.02.2023.
//

import Foundation

protocol MonthListDelegate {
    func onSuccessGetAllMonths(months: [Months])
    func onError(error: String?)
}
