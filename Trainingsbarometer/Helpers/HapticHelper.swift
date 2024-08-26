//
//  HapticHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 22.08.2024.
//

import Foundation
import SwiftUI

struct HapticHelper {
    
    // MARK: Simplify the generation of haptic feedback
    
    
    // Standard button press triggers feedback "Impact"
    static func impact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    // Feedback "Sucess"
    static func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    // Feedback "Warning"
    static func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
}
