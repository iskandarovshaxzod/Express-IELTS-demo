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
    
    // Using CAMediaTimingFunction
    func shake(duration: TimeInterval, values: [CGFloat] = [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0]) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.values   = values
        self.layer.add(animation, forKey: "shake")
    }
    
    // Using CABasicAnimation
    func shake(duration: TimeInterval = 0.05, shakeCount: Float = 6,
               xValue: CGFloat = 12, yValue: CGFloat = 0){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration     = duration
        animation.repeatCount  = shakeCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - xValue, y: self.center.y - yValue))
        animation.toValue   = NSValue(cgPoint: CGPoint(x: self.center.x + xValue, y: self.center.y - yValue))
        self.layer.add(animation, forKey: "shake")
    }
    
    // Using SpringWithDamping
    func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.transform = CGAffineTransform.identity
        }
    }
}
