//
//  Teacher.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.02.2023.
//

import Foundation

struct Teacher: Codable {
    let id: UUID?
    let teacherName: String
    let isValid: Bool
    let branch: BranchID
    
    init(id: UUID? = nil, teacherName: String, isValid: Bool = true, branch: BranchID) {
        self.id = id
        self.teacherName = teacherName
        self.isValid     = isValid
        self.branch      = branch
    }
}
