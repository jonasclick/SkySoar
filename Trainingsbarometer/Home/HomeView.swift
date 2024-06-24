//
//  HomeView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var flightLogs: [FlightLog]
    
    @State private var hours = Double()
    @State private var starts = Double()
    @State private var trainingState = Int()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                BackgroundView()
                
                VStack (alignment: .leading) {
                    // Headline Section
                    Text("Übungsstand")
                        .font(.sectionHeadline)
                        .padding(.bottom, 13)
                    
                    HeadlineView(trainingState: $trainingState)

                    // Info Card
                    if trainingState == 1 {
                        InfoCardRedView()
                    }
                    else if trainingState == 2 {
                        InfoCardYellowView()
                    }
                    else if trainingState == 3 {
                        InfoCardGreenView()
                    }
                    
                    
                    // Stats Section
                    Text("In den letzten sechs Monaten")
                        .font(.sectionHeadline)
                        .padding(.bottom, 0.5)
                    Text(sixMonthsRange())
                        .font(.sectionHeadline)
                        .opacity(0.5)
                        .padding(.bottom, 15)
                    
                    HStack {
                        // Stat Hours
                        StatCardView(image: "clock", number: flightHoursInSixMonths(flightLogs: flightLogs), label: "Stunden")
                            .padding(.trailing, 50)
                        // Stat Starts
                        StatCardView(image: "airplane.departure", number: flightLogsInSixMonths(flightLogs: flightLogs), label: "Starts")
                    }
                }
                .padding(.horizontal, 20)
                
                // Navigation Buttons
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink (destination: FlightLogsView()) {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 30))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(35)
                }
            }
            .ignoresSafeArea()
            .onAppear {
                hours = flightHoursInSixMonths(flightLogs: flightLogs)
                starts = flightLogsInSixMonths(flightLogs: flightLogs)
                trainingState = calculateTrainingState(hours: hours, starts: starts)
            }
        }
    }
    
    func sixMonthsRange() -> String {
        let today = Date()
        guard let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: today) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let todayString = dateFormatter.string(from: today)
        let sixMonthsAgoString = dateFormatter.string(from: sixMonthsAgo)
        
        return "\(sixMonthsAgoString) – \(todayString)"
    }
    
    func flightHoursInSixMonths(flightLogs: [FlightLog]) -> Double {
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
    
    func flightLogsInSixMonths(flightLogs: [FlightLog]) -> Double {
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
    
    func calculateTrainingState(hours: Double, starts: Double) -> Int {
        // Boundary equations according to training barometer
        let redYellowBoundary = (20 - hours) / 0.7
        let yellowGreenBoundary = (39 - hours) / 0.65
        
        if starts > yellowGreenBoundary {
            return 3 // Training State Green
        } else if starts > redYellowBoundary {
            return 2 // Training State Yellow
        } else {
            return 1 // Training State Red
        }
    }
}

#Preview {
    HomeView()
}
