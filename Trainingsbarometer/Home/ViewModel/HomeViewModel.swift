//
//  HomeViewModel.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 26.09.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    
    // MARK: Practice State Logic
    // Calculate Practice State using hours and starts within last 6 months
    func calculatePracticeStateInt(hours: Double, starts: Double) -> Int {
        
        // Boundary equations according to training barometer
        let redYellowBoundary = (20 - hours) / 0.7
        let yellowGreenBoundary = (39 - hours) / 0.65
        
        // Return Practice State as Int
        if starts > yellowGreenBoundary {
            return 3 // Practice State Green
        } else if starts > redYellowBoundary || starts == yellowGreenBoundary {
            return 2 // Practice State Yellow
        } else if starts > 0 && starts <= redYellowBoundary {
            return 1 // Practice State Red
        } else if starts == 0 {
            return 0 // No flights have been added yet
        } else {
            return 0 // Default return
        }
    }
    
    func flightTimeForFunction(flightLogs: [FlightLog], selectedFunction: PilotFunctionTime, startMonthsAgo: Int, endMonthsAgo: Int) -> Double {
        
        let calendar = Calendar.current
        guard let startDate = calendar.date(byAdding: .month, value: -startMonthsAgo, to: Date()) else { return 0.0 }
        guard let endDate = calendar.date(byAdding: .month, value: -endMonthsAgo, to: Date()) else { return 0.0 }
        
        let filteredLogs = flightLogs.filter { flightLog in
            
            /// If function is PIC, instructor time also needs to be included, as instructor time also
            /// counts as PIC time.
            if selectedFunction == PilotFunctionTime.pic {
                if flightLog.pilotFunctionTime != PilotFunctionTime.dual {
                    if let arrivalDate = flightLog.arrivalDate { return arrivalDate >= startDate && arrivalDate <= endDate }
                }
            } else {
                if flightLog.pilotFunctionTime == selectedFunction {
                    if let arrivalDate = flightLog.arrivalDate { return arrivalDate >= startDate && arrivalDate <= endDate }
                }
            }
            
            return false
            
        }
        
        let totalSeconds = filteredLogs.reduce(0) { $0 + $1.flightTime }
        let totalHours = totalSeconds / 3600
        return round(totalHours * 10) / 10.0
    }
    
    func flightsForDepartureMode(flightLogs: [FlightLog], departureMode: DepartureMode, startMonthsAgo: Int, endMonthsAgo: Int) -> Int {
        
        let calendar = Calendar.current
        guard let startDate = calendar.date(byAdding: .month, value: -startMonthsAgo, to: Date()) else { return 0 }
        guard let endDate = calendar.date(byAdding: .month, value: -endMonthsAgo, to: Date()) else { return 0 }
        
        let filteredLogs = flightLogs.filter { flightLog in
            if flightLog.departureMode == departureMode {
                if let arrivalDate = flightLog.arrivalDate { return arrivalDate >= startDate && arrivalDate <= endDate }
            }
            return false
        }
        
        return filteredLogs.count
    }
}
