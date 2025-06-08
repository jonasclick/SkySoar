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
    
    var sfSymbolName: String {
        switch self {
        case .winch:
            return "w.circle.fill"
        case .aerotow:
            return "a.circle.fill"
        case .selfLaunching:
            return "s.circle.fill"
        }
    }
    
    private var labelKey: String {
        switch self {
        case .winch: return "winch_launches"
        case .aerotow: return "aerotows"
        case .selfLaunching: return "self_launches"
        }
    }
    
    var localizedLabel: String {
        NSLocalizedString(labelKey, comment: "Label for start types")
    }
    
}
