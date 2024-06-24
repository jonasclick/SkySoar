//
//  FlightLogCardView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 12.06.2024.
//

import SwiftUI

struct FlightLogCardView: View {
    
    var flightLog: FlightLog
    
    var body: some View {
        // Flight Log Card
        VStack {
            HStack (spacing: 22) {
                
                // Departure Information
                VStack (alignment: .leading) {
                    Text(flightLog.departureLocation)
                        .font(.flightLogPrimary)
                    Text("\(returnHoursMinutes(from: flightLog.departureDate!)) Uhr")
                        .font(.flightLogSecondary)
                        .opacity(0.7)
                }
                
                HStack (spacing: 0) {
                    Image(systemName: flightLog.departureModeSymbol)
                    Rectangle()
                        .frame(height: 1)
                    Circle()
                        .frame(height: 5)
                }
                
                // Arrival Information
                VStack (alignment: .leading) {
                    Text(flightLog.arrivalLocation)
                        .font(.flightLogPrimary)
                    Text("\(returnHoursMinutes(from: flightLog.arrivalDate!)) Uhr")
                        .font(.flightLogSecondary)
                        .opacity(0.7)
                }
            }
            
            HStack {
                VStack (alignment: .leading, spacing: 7) {
                    Spacer()
                    // Aircraft Information
                    HStack {
                        Text(flightLog.aircraftModel)
                            .font(.flightLogPrimary)
                        Text(flightLog.aircraftRegistration)
                            .font(.flightLogSecondary)
                            .opacity(0.7)
                    }
                    // Remarks
                    Text(flightLog.remarks)
                        .font(.flightLogSecondary)
                        .opacity(0.7)
                }
                Spacer()
                VStack (alignment: .leading) {
                    Spacer()
                    // Pilot Function
                    Text(flightLog.pilotFunctionString)
                        .font(.flightLogSecondary)
                        .opacity(0.7)
                    // Flight Time
                    Text(formattedFlightTime(flightLog.flightTime))
                        .font(.flightLogPrimary)
                }
            }
        }
        .padding()
        .frame(width: 370, height: 124)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 5, y: 5)
    }
    
    // Helper method to format Date to "HH:mm"
    private func returnHoursMinutes(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    // Helper method to format Date to "HH"
    private func returnHours(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
    }
    
    // Helper method to format Date to "mm"
    private func returnMinutes(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: date)
    }
    
    // Helper method to format flight time string
    private func formattedFlightTime(_ timeInterval: TimeInterval) -> String {
        let totalMinutes = Int(timeInterval) / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60

        if hours > 0 {
            return "\(hours) h \(minutes) min"
        } else {
            return "\(minutes) min"
        }
    }
}
