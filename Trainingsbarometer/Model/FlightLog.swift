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
    var departureDate: Date = Date()

    var arrivalLocation: String = ""
    var arrivalDate: Date = Date()
    
    var aircraftModel: String = ""
    var aircraftRegistration: String = ""

    var flightTime: Date = Date()

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
    
    var departureModeSymbol: String {
        switch departureMode {
        case .winch:
            return "w.square"
        case .aerotow:
            return "a.square"
        case .selfLaunching:
            return "s.square"
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
