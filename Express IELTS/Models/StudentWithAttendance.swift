//
//  StudentWithAttendance.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 13.02.2023.
//

import Foundation

struct StudentWithAttendance: Codable {
    let student: Student
    let attendances: [Attendance]
    let paymentStatus: Double
}
