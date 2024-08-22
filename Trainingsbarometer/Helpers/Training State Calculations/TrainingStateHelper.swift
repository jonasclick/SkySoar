//
//  TrainingStateHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 19.08.2024.
//

import Foundation

struct TrainingStateHelper {
    
    static func flightHoursInSixMonths(flightLogs: [FlightLog]) -> Double {
        let calendar = Calendar.current
        let today = Date()
        guard let sixMonthsAgo = calendar.date(byAdding: .month, value: -6, to: today) else {
            return 0.0
        }
        
        let filteredLogs = flightLogs.filter { flightLog in
            if let arrivalDate = flightLog.arrivalDate {
                return arrivalDate >= sixMonthsAgo && arrivalDate <= today
            }
            return false
        }
        
        let totalSeconds = filteredLogs.reduce(0) { $0 + $1.flightTime }
        let totalHours = totalSeconds / 3600
        return round(totalHours * 10) / 10.0 // Round to one decimal place
    }
    
    static func flightLogsInSixMonths(flightLogs: [FlightLog]) -> Double {
        let calendar = Calendar.current
        let today = Date()
        guard let sixMonthsAgo = calendar.date(byAdding: .month, value: -6, to: today) else {
            return 0.0
        }
        
        let filteredLogs = flightLogs.filter { flightLog in
            if let arrivalDate = flightLog.arrivalDate {
                return arrivalDate >= sixMonthsAgo && arrivalDate <= today
            }
            return false
        }
        
        return Double(filteredLogs.count)
    }
    
    // Calculate Training State using hours and starts within last 6 months
    static func calculateTrainingStateInt(hours: Double, starts: Double) -> Int {
        
        // Boundary equations according to training barometer
        let redYellowBoundary = (20 - hours) / 0.7
        let yellowGreenBoundary = (39 - hours) / 0.65
        
        // Return Training State as Int
        if starts > yellowGreenBoundary {
            return 3 // Training State Green
        } else if starts > redYellowBoundary || starts == yellowGreenBoundary {
            return 2 // Training State Yellow
        } else if starts > 0 && starts <= redYellowBoundary {
            return 1 // Training State Red
        } else if starts == 0 {
            return 0 // No flights have been added yet
        } else {
            return 0 // Default return
        }
    }
    
    
    // Only dispaly one decimal of a double and only if not .0
    static func noDotZero(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            // If the number is an integer, display without decimal
            return String(format: "%.0f", number)
        } else {
            // If the number has a fractional part, display one decimal
            return String(format: "%.1f", number)
        }
    }
    
}
