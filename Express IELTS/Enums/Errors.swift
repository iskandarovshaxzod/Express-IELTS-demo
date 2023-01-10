//
//  Errors.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 06.01.2023.
//

import Foundation

enum Errors: Error {
    case userNotFound
    case invalidSum
}

extension Errors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userNotFound:
            return NSLocalizedString("There is no account that matches with your email and password",
                                     comment: "")
        case .invalidSum:
            return NSLocalizedString("Sum is not in correct format",
                                     comment: "")
        }
    }
}
