//
//  HapticHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 22.08.2024.
//

import Foundation
import SwiftUI

struct HapticHelper {
    
    static func impact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    static func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    static func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
}
