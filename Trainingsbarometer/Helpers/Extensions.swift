//
//  Extensions.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 26.09.2024.
//

import Foundation

extension Double {
    
    // Only dispaly one decimal of a double and only if not .0
    var noDotZero: String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            // If the number is an integer, display without decimal
            return String(format: "%.0f", self)
        } else {
            // If the number has a fractional part, display one decimal
            return String(format: "%.1f", self)
        }
    }
}
