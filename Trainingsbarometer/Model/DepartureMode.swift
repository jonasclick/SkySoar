//
//  DepartureMode.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 25.09.2024.
//

import Foundation

enum DepartureMode: Int, Codable {
    case winch = 0
    case aerotow = 1
    case selfLaunching = 2
    
    
    func sfSymbol() -> String {
        switch self {
        case .winch:
            return "w.circle.fill"
        case .aerotow:
            return "a.circle.fill"
        case .selfLaunching:
            return "s.circle.fill"
        }
    }
    
    func labelEN() -> String {
        switch self {
        case .winch:
            return "Winch Launch."
        case .aerotow:
            return "Aerotows"
        case .selfLaunching:
            return "Self Launches"
        }
    }
}
