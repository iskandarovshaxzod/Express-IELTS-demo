//
//  Database.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import Foundation
import UIKit

struct Database {
    
    private init() {}
    
    static var shared    = Database()
    static var isAdmin   = false
    static var branchID  = ""
    static var teacherID = ""
    static var configID  = ""
    static var groupID   = ""
    
    var language: Language {
        get{
            let lan = Defaults.defaults.string(forKey: "language") ?? "en"
            return Language(rawValue: lan) ?? .english
        }
    }
    var userMode: Usermode {
        get{
            let mode = Defaults.defaults.integer(forKey: "user_mode")
            return Usermode(rawValue: mode) ?? .system
        }
    }
}

/*
 size-> 20.0 | toppadding
 size-> 59.0 | toppadding
 
 size-> 375.0 | width
 size-> 428.0 | width
*/
