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
    
    var departurePlace: String = ""
    var departureDate: Date = Date()

    var arrivalPlace: String = ""
    var arrivalDate: Date = Date()
    
    var aircraftModel: String = ""
    var aircraftRegistration: String = ""
    
    // Computed property to calculate flight time in minutes
    var flightTime: Int {
        let timeInterval = arrivalDate.timeIntervalSince(departureDate)
        return Int(timeInterval / 60)
    }

    var departureMode = DepartureMode.aerotow
    
    var pilotFunctionTime = PilotFunctionTime.pic
    
    var remarks: String = ""
    
    init() {
        id = UUID().uuidString
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
