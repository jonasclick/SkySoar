//
//  DateHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 09.08.2024.
//

import Foundation

struct DateHelper {
    
    // Helper Method for EditFlightLogView to calculate difference between two Dates for automatic flight time calculation
    static func calculateTimeDifference(from: Date, to: Date) -> (hours: Int, minutes: Int) {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour, .minute], from: from, to: to)
        
        return (components.hour ?? 0, components.minute ?? 0)
    }
    
    // Helper Method for EditFlightLogView to round the seconds of a date, for a correct minute result in calculateTimeDifference()
    static func removeSeconds(from date: Date) -> Date {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        return calendar.date(from: components) ?? date
    }
    
    
}
