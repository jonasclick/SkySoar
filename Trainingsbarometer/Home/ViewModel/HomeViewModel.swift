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
    
    // Boundary equations according to practice barometer
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
  
  /// Calculates a continuous practice state value as Double
  /// 1.00 - 1.99 for the red area, 2.00 - 2.99 for the yellow area
  /// > 3.00 for the green area
  func calculatePracticeStateDouble(hours: Double, starts: Double) -> Double {
    
    // Boundary equations according to practice barometer
    let redYellowBoundary = (20 - hours) / 0.7
    let yellowGreenBoundary = (39 - hours) / 0.65
    
    if starts <= 0 {
      return 0.0
    } else if starts <= redYellowBoundary {
      // Linear scale from 1.0 to just below 2.0
      let ratio = starts / redYellowBoundary
      return max(1.0, 1.0 + ratio * 0.99)
    } else if starts <= yellowGreenBoundary {
      // Linear scale from 2.0 to just below 3.0
      let ratio = (starts - redYellowBoundary) / (yellowGreenBoundary - redYellowBoundary)
      return max(2.0, 2.0 + ratio * 0.99)
    } else {
      // Linear scale from 3.0 upwards
      // Aim: at around 30 hours and 45 starts, the value should be ~4.0
      // Derive slope so that (starts = 45) ⇒ score = 4.0 when hours = 30
      let targetStarts = 45.0
      let targetScore = 4.0
      let slope = (targetScore - 3.0) / (targetStarts - yellowGreenBoundary)
      let ratio = starts - yellowGreenBoundary
      return max(3.0, 3.0 + ratio * slope)
    }
  }
  
  func flightTimeForFunction(flightLogs: [FlightLog], selectedFunction: PilotFunctionTime, startDate: Date, endDate: Date) -> Double {
    
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
  
  func flightsForDepartureMode(flightLogs: [FlightLog], departureMode: DepartureMode, startDate: Date, endDate: Date) -> Int {
    
    let filteredLogs = flightLogs.filter { flightLog in
      if flightLog.departureMode == departureMode {
        if let arrivalDate = flightLog.arrivalDate { return arrivalDate >= startDate && arrivalDate <= endDate }
      }
      return false
    }
    
    return filteredLogs.count
  }
}
