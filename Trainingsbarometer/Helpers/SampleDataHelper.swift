//
//  SampleDataHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.07.2024.
//

import Foundation
import SwiftData

struct SampleDataHelper {
    
    
    // Helper to return a Date Type with specified offset from current date (whenever function gets triggered)
    static func setDateTime(dayOffset: Int, hour: Int, minute: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        
        var date = Calendar.current.date(from: components)!
        
        if dayOffset != 0 { date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date)! }
        
        return date
    }
    
    
    
    // Add sample flight log with some default values for when not specified in call and some hard-coded values
    static func addFlightLog(context: ModelContext, departureL: String = "Mollis", departureD: Date, arrivalL: String = "Mollis", arrivalD: Date, flightTime: TimeInterval, departureM: DepartureMode = DepartureMode.aerotow) {
        
        let flightLog = FlightLog()
        
        flightLog.isSampleData = true
        
        flightLog.departureLocation = departureL
        flightLog.departureDate = departureD
        
        flightLog.arrivalLocation = arrivalL
        flightLog.arrivalDate = arrivalD
        
        flightLog.aircraftModel = "Arcus M" // hard coded value for all sample flights
        flightLog.aircraftRegistration = "HB-1234" // hard coded value for all sample flights
        
        flightLog.flightTime = flightTime
        
        flightLog.departureMode = departureM
        flightLog.pilotFunctionTime = PilotFunctionTime.pic
        
        flightLog.remarks = (Locale.current.language.languageCode?.identifier ?? "") == "de" ? "Achtung: Beispiel-Flug" : "Caution: Sample flight"
        
        context.insert(flightLog)
    }
    
    
    // Add 10 predefined sample flights
    static func addSampleData(context: ModelContext) {
        
        // 1
        addFlightLog(context: context, departureD: setDateTime(dayOffset: -1, hour: 11, minute: 4), arrivalD: setDateTime(dayOffset: -1, hour: 14, minute: 44), flightTime: 13260, departureM: DepartureMode.aerotow)
        // 2
        addFlightLog(context: context, departureD: setDateTime(dayOffset: -14, hour: 10, minute: 37), arrivalD: setDateTime(dayOffset: -14, hour: 10, minute: 44), flightTime: 420, departureM: DepartureMode.winch)
        // 3
        addFlightLog(context: context, departureD: setDateTime(dayOffset: -14, hour: 11, minute: 14), arrivalD: setDateTime(dayOffset: -14, hour: 14, minute: 26), flightTime: 11520, departureM: DepartureMode.winch)
        // 4
        addFlightLog(context: context, departureD: setDateTime(dayOffset: -30, hour: 10, minute: 34), arrivalD: setDateTime(dayOffset: -30, hour: 15, minute: 05), flightTime: 16260, departureM: DepartureMode.winch)
        // 5
        addFlightLog(context: context, departureD: setDateTime(dayOffset: -44, hour: 11, minute: 03), arrivalD: setDateTime(dayOffset: -44, hour: 17, minute: 17), flightTime: 22440, departureM: DepartureMode.selfLaunching)
        // 6
        addFlightLog(context: context, departureD: setDateTime(dayOffset: -60, hour: 10, minute: 20), arrivalL: "Grenchen", arrivalD: setDateTime(dayOffset: -60, hour: 12, minute: 34), flightTime: 8040, departureM: DepartureMode.aerotow)
        // 7
        addFlightLog(context: context, departureL: "Grenchen", departureD: setDateTime(dayOffset: -60, hour: 14, minute: 33), arrivalD: setDateTime(dayOffset: -60, hour: 16, minute: 24), flightTime: 6660, departureM: DepartureMode.aerotow)
        // 8
        addFlightLog(context: context, departureL: "Amlikon", departureD: setDateTime(dayOffset: -74, hour: 11, minute: 15), arrivalL: "Amlikon", arrivalD: setDateTime(dayOffset: -74, hour: 12, minute: 33), flightTime: 4680, departureM: DepartureMode.winch)
        // 9
        addFlightLog(context: context, departureL: "Amlikon", departureD: setDateTime(dayOffset: -74, hour: 15, minute: 43), arrivalL: "Amlikon", arrivalD: setDateTime(dayOffset: -74, hour: 16, minute: 46), flightTime: 3720, departureM: DepartureMode.winch)
        // 10
        addFlightLog(context: context, departureD: setDateTime(dayOffset: -90, hour: 9, minute: 47), arrivalD: setDateTime(dayOffset: -90, hour: 10, minute: 46), flightTime: 3540, departureM: DepartureMode.aerotow)
        
    }
    
    // check for sample data (if app has at least one sample flight)
    static func initializeIsSampleData(from flightLogs: [FlightLog]) -> Bool {
        var count = 0
        
        for flightLog in flightLogs {
            if flightLog.isSampleData { count += 1 }
        }
        
        return count != 0
    }
}
