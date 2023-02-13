//
//  Group.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 11.02.2023.
//

import Foundation

struct Group: Codable {
    let id: UUID?
    let groupName: String
    let groupType: String
    let isValid: Bool
    let config:  ConfigID
    
    init(id: UUID? = nil, groupName: String, groupType: String, isValid: Bool = true, config: ConfigID) {
        self.id = id
        self.groupName = groupName
        self.groupType = groupType
        self.isValid = isValid
        self.config  = config
    }
}
