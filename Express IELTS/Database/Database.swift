//
//  Database.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 08.12.2022.
//

import Foundation
import UIKit

struct Database {
    static var shared = Database()
    var isAdmin       = false
    var userMode: Usermode = .light{
        didSet{
            print("mode: \(userMode.rawValue)")
            userModeChanged()
        }
    }
    var language: Language = .english
    
    
    //MARK: Methods
  
    func userModeChanged() {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            print("delegate: scene")
            scene.blurEffect = UIBlurEffect(style: userMode == .light ? .light : .dark)
        }
        if let myDelegate = UIApplication.shared.delegate as? AppDelegate {
            print("delegate: app")
            myDelegate.blurStyle = (userMode == .light ? .light : .dark)
        }
    }
}

/*
 size-> 20.0 | toppadding
 size-> 59.0 | toppadding
 
 
 size-> 375.0 | width
 size-> 428.0 | width

 
*/
