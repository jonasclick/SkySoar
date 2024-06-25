//
//  FlightLog.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import Foundation
import SwiftData

@Model
class FlightLog: Identifiable {
    
    @Attribute(.unique) var id: String
    
    var departureLocation: String = ""
    var departureDate: Date?

    var arrivalLocation: String = ""
    var arrivalDate: Date?
    
    var aircraftModel: String = ""
    var aircraftRegistration: String = ""

    var flightTime: TimeInterval = 0 // Flight duration in seconds

    var departureMode = DepartureMode.winch
    
    var pilotFunctionTime = PilotFunctionTime.pic
    
    var remarks: String = ""
    
    init() {
        id = UUID().uuidString
    }
    
    var pilotFunctionString: String {
            switch pilotFunctionTime {
            case .pic:
                return "PIC"
            case .dual:
                return "Dual"
            case .instructorAndPic:
                return "Instructor"
            }
        }
    
    var departureModeString: String {
        switch departureMode {
        case .winch:
            return "W"
        case .aerotow:
            return "A"
        case .selfLaunching:
            return "S"
        }
    }
    
    var departureModeSymbol: String {
        switch departureMode {
        case .winch:
            return "w.circle.fill"
        case .aerotow:
            return "a.circle.fill"
        case .selfLaunching:
            return "s.circle.fill"
        }
    }
    
}

enum DepartureMode: Codable {
    case winch
    case aerotow
    case selfLaunching
}

enum PilotFunctionTime: Codable {
    case pic
    case dual
    case instructorAndPic
}
