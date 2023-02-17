//
//  Payment.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.02.2023.
//

import Foundation

struct Payment: Codable {
    let id:   UUID?
    let date: String?
    let paidSum: Double
    let maxSum:  Double
    let student: StudentID
    let byTeacher: TeacherID
    let group:   GroupID
    
    init(id: UUID? = nil, date: String? = nil, paidSum: Double, maxSum: Double, student: StudentID, byTeacher: TeacherID, group: GroupID) {
        self.id = id
        self.date = date
        self.paidSum = paidSum
        self.maxSum = maxSum
        self.student = student
        self.byTeacher = byTeacher
        self.group = group
    }
}
