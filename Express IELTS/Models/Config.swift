//
//  Config.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.02.2023.
//

import Foundation

struct Config: Codable {
    let id: UUID?
    let configName: String
    let isValid: Bool
    let teacher: TeacherID
    
    init(id: UUID? = nil, configName: String, isValid: Bool = true, teacher: TeacherID) {
        self.id = id
        self.configName = configName
        self.isValid = isValid
        self.teacher = teacher
    }
}
