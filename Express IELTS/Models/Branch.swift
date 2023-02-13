//
//  Branch.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.02.2023.
//

import Foundation

struct Branch: Codable {
    let id: UUID?
    let branchName: String
    let password:   String
    let isValid:    Bool
    
    init(id: UUID? = nil, branchName: String, password: String, isValid: Bool = true) {
        self.id = id
        self.branchName = branchName
        self.password   = password
        self.isValid    = isValid
    }
}
