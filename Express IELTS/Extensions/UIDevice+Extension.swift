//
//  UIDevice.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 23.11.2022.
//

import AVFoundation
import AudioToolbox
import Foundation
import UIKit
import CoreHaptics

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}


final class HapticsManager {
    static func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notification = UINotificationFeedbackGenerator()
            notification.prepare()
            notification.notificationOccurred(type)
        }
    }
}
