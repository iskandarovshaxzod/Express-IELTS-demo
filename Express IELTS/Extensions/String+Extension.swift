//
//  String+Extension.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 14.12.2022.
//

import Foundation
import UIKit

extension String {
    
    var color: UIColor {
        return UIColor(named: self) ?? .white
    }
    
    var localized: String {
        if let path = Bundle.main.path(forResource: Database.shared.language.rawValue, ofType: "lproj"){
            if let bundle = Bundle(path: path){
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        }
        return ""
    }
    
    var date: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date: Date? = dateFormatterGet.date(from: self)
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        if let date{
            return dateFormatterPrint.string(from: date)
        }
        return ""
    }
    
}
