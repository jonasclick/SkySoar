//
//  FlightLog.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import Foundation
import SwiftData

@Model
class FlightLog: Identifiable, Codable {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
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
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case isSampleData
        case isAutoFlightTime
        case departureLocation
        case departureDate
        case arrivalLocation
        case arrivalDate
        case aircraftModel
        case aircraftRegistration
        case flightTime
        case departureMode
        case pilotFunctionTime
        case remarks
    }
    
    // Encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(isSampleData, forKey: .isSampleData)
        try container.encode(isAutoFlightTime, forKey: .isAutoFlightTime)
        try container.encode(departureLocation, forKey: .departureLocation)
        try container.encode(departureDate, forKey: .departureDate)
        try container.encode(arrivalLocation, forKey: .arrivalLocation)
        try container.encode(arrivalDate, forKey: .arrivalDate)
        try container.encode(aircraftModel, forKey: .aircraftModel)
        try container.encode(aircraftRegistration, forKey: .aircraftRegistration)
        try container.encode(flightTime, forKey: .flightTime)
        try container.encode(departureMode, forKey: .departureMode)
        try container.encode(pilotFunctionTime, forKey: .pilotFunctionTime)
        try container.encode(remarks, forKey: .remarks)
    }
    
    
    // Decoding
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        isSampleData = try container.decode(Bool.self, forKey: .isSampleData)
        isAutoFlightTime = try container.decode(Bool.self, forKey: .isAutoFlightTime)
        departureLocation = try container.decode(String.self, forKey: .departureLocation)
        departureDate = try container.decodeIfPresent(Date.self, forKey: .departureDate)
        arrivalLocation = try container.decode(String.self, forKey: .arrivalLocation)
        arrivalDate = try container.decodeIfPresent(Date.self, forKey: .arrivalDate)
        aircraftModel = try container.decode(String.self, forKey: .aircraftModel)
        aircraftRegistration = try container.decode(String.self, forKey: .aircraftRegistration)
        flightTime = try container.decode(TimeInterval.self, forKey: .flightTime)
        departureMode = try container.decode(DepartureMode.self, forKey: .departureMode)
        pilotFunctionTime = try container.decode(PilotFunctionTime.self, forKey: .pilotFunctionTime)
        remarks = try container.decode(String.self, forKey: .remarks)
    }
    
    
}


