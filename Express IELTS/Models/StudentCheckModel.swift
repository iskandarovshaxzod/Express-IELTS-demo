//
//  StudentCheckModel.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 04.01.2023.
//

import UIKit

struct StudentCheckModel {
    let studentName: String
    let months: [EachMonthModel]
}

struct EachMonthModel {
    let monthName: String
    let days:      [String : Int]?
}
