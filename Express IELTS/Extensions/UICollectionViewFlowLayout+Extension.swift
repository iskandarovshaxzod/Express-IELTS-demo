//
//  UICollectionViewFlowLayout+Extension.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 12.12.2022.
//

import Foundation
import UIKit

extension UICollectionViewFlowLayout{
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
    
    open override var developmentLayoutDirection: UIUserInterfaceLayoutDirection {
        return UIUserInterfaceLayoutDirection.rightToLeft
    }
}
