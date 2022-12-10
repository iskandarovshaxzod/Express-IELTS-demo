//
//  UITextField.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 24.11.2022.
//

import Foundation
import UIKit

extension UITextField{
    func setLeftPadding(inset: CGFloat){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftViewMode = UITextField.ViewMode.always
    }
}
