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
    
    @State private var isSettingsPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                BackgroundView()
                
                VStack (alignment: .leading) {
                    // Headline Section
                    Text("Practice State")
                        .font(.sectionHeadline)
                        .padding(.bottom, 13)
                    
                    HeadlineView(trainingState: $trainingState)
                    
                    // Info Card
                    if trainingState == 1 {
                        InfoCardRedView()
                            .padding(.bottom, 40)
                    }
                    else if trainingState == 2 {
                        InfoCardYellowView()
                            .padding(.bottom, 40)
                    }
                    else if trainingState == 3 {
                        InfoCardGreenView()
                            .padding(.bottom, 40)
                    }
                    
                    
                    // Stats Section
                    Text("In the past six months")
                        .font(.sectionHeadline)
                        .padding(.bottom, 0.5)
                    Text(sixMonthsRange())
                        .font(.sectionHeadline)
                        .opacity(0.5)
                        .padding(.bottom, 15)
                    
                    HStack {
                        Spacer()
                        
                        // Stat Hours
                        StatCardView(image: "clock", number: flightHoursInSixMonths(flightLogs: flightLogs), label: "Hours")
                        Spacer()
                        Spacer()
                        
                        // Stat Starts
                        StatCardView(image: "airplane.departure", number: flightLogsInSixMonths(flightLogs: flightLogs), label: "Starts")
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                
                // Navigation Buttons
                VStack {
                    Spacer()
                    HStack {
                        
                        Button(action: {
                            isSettingsPresented = true
                        }, label: {
                            Image(systemName: "gearshape")
                                .font(.system(size: 25))
                        })
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        NavigationLink (destination: FlightLogsView()) {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 30))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(35)
                }
                
                // Show warning if app is using sample data
                SampleDataWarningView()
                    .padding(.top, 8)
                
            }
            .ignoresSafeArea()
            .onAppear {updateTrainingState()}
            .sheet(isPresented: $isSettingsPresented, onDismiss: {updateTrainingState()}) {
                SettingsView()
            }
        }
    }
    
    private func sixMonthsRange() -> String {
        let today = Date()
        // Get date 6 months ago
        guard let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: today) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = (Locale.current.language.languageCode?.identifier ?? "") == "de" ? "dd.MM.yyyy" : "MMMM dd, yyyy"
        
        let todayString = dateFormatter.string(from: today)
        let sixMonthsAgoString = dateFormatter.string(from: sixMonthsAgo)
        
        return "\(sixMonthsAgoString) – \(todayString)"
    }
    
    private func flightHoursInSixMonths(flightLogs: [FlightLog]) -> Double {
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
    
    private func flightLogsInSixMonths(flightLogs: [FlightLog]) -> Double {
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
    
    private func calculateTrainingStateInt(hours: Double, starts: Double) -> Int {
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
    
    private func updateTrainingState() {
        hours = flightHoursInSixMonths(flightLogs: flightLogs)
        starts = flightLogsInSixMonths(flightLogs: flightLogs)
        trainingState = calculateTrainingStateInt(hours: hours, starts: starts)
    }
}

#Preview {
    HomeView()
}
