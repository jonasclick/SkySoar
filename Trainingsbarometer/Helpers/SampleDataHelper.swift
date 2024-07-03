//
//  SampleDataHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.07.2024.
//

import Foundation

struct SampleDataHelper {
    static func initializeIsSampleData(from flightLogs: [FlightLog]) -> Bool {
        var count = 0
        
        for flightLog in flightLogs {
            if flightLog.isSampleData {
                count += 1
            }
        }
        
        return count != 0
    }
}
