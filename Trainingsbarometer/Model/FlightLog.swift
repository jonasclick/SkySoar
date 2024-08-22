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
    
    var isSampleData: Bool = false
    var isAutoFlightTime: Bool = true
    
    var departureLocation: String = ""
    var departureDate: Date?

    var arrivalLocation: String = ""
    var arrivalDate: Date?
    
    var aircraftModel: String = ""
    var aircraftRegistration: String = ""

    var flightTime: TimeInterval = 0 // Flight duration stored in seconds but edited and displayed in hours and minutes, no seconds.

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

enum PilotFunctionTime: Int, Codable  {
    case pic = 0
    case dual = 1
    case instructorAndPic = 2
    
    func sfSymbol() -> String {
        switch self {
        case .pic:
            return "person"
        case .dual:
            return "person.2"
        case .instructorAndPic:
            return "graduationcap"
        }
    }
    
    func labelEN() -> String {
        switch self {
        case .pic:
            return "Hours PIC"
        case .dual:
            return "Hours Dual"
        case .instructorAndPic:
            return "Hours Instruct."
        }
    }
}
