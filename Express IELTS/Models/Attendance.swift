//
//  Attendance.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.02.2023.
//

import Foundation

struct Attendance: Codable {
    let id:   UUID?
    let date: String?
    let isPresent: Bool
    let student:   StudentID
    
    init(id: UUID? = nil, date: String? = nil, isPresent: Bool, student: StudentID) {
        self.id   = id
        self.date = date
        self.isPresent = isPresent
        self.student   = student
    }
}
