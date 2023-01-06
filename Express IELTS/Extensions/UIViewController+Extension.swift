//
//  UIViewController+Extension.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.12.2022.
//

import UIKit

extension UIViewController{
    var window: UIWindow? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }
}
