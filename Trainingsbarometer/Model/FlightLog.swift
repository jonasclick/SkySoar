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

    var departureMode = DepartureMode.aerotow
    
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
    
}

enum DepartureMode: Codable {
    case aerotow
    case winch
    case selfLaunching
}

enum PilotFunctionTime: Codable {
    case pic
    case dual
    case instructorAndPic
}
