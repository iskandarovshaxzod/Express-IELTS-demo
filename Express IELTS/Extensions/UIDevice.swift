//
//  UIDevice.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import Foundation
import UIKit
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
