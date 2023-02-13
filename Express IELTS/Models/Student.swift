//
//  Student.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.02.2023.
//

import Foundation

struct Student: Codable {
    let id: UUID?
    let studentName: String
    let phoneNumber: String
    let joinedDate: String?
    let leftDate:   String?
    let group:  GroupID
    let branch: BranchID
    
    init(id: UUID? = nil, studentName: String, phoneNumber: String, joinedDate: String? = nil, leftDate: String? = nil, group: GroupID, branch: BranchID) {
        self.id = id
        self.studentName = studentName
        self.phoneNumber = phoneNumber
        self.joinedDate  = joinedDate
        self.leftDate    = leftDate
        self.group  = group
        self.branch = branch
    }
}
