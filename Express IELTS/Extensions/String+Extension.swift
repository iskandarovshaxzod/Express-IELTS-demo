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
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
    
    var color: UIColor {
        return UIColor(named: self) ?? .white
    }
}
