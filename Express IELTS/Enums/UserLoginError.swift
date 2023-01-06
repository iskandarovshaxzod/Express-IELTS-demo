//
//  UserLoginError.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 06.01.2023.
//

import Foundation

enum UserLoginError: Error {
    case notFound
}

extension UserLoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("There is no account that match with your email and password",
                                     comment: "")
        }
    }
}
