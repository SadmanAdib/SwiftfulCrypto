//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Sadman Adib on 20/10/22.
//

import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
