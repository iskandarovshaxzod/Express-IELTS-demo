//
//  String+Extension.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 14.12.2022.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        if let path = Bundle.main.path(forResource: Database.shared.language.rawValue, ofType: "lproj"){
            if let bundle = Bundle(path: path){
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        }
        return ""
    }
    
    var color: UIColor {
        return UIColor(named: self) ?? .white
    }
}
