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
  
  @ObservedObject private var viewModel = HomeViewModel()
  
  @AppStorage("FilterLogic") var filterLogic = FilterLogic.total
  @AppStorage("ShowFunctionTime") var showFunctionTime = PilotFunctionTime.pic
  @AppStorage("showDepartureMode") var showDepartureMode = DepartureMode.winch
  @AppStorage("isPracticeStateDetailed") var isPracticeStateDetailed = false
  
  @State private var dateRange: String = "This Year"
  @State private var hours = Double()
  @State private var starts = Double()
  @State private var practiceState = Int()
  @State private var practiceStateDouble = Double()
  @State private var isSettingsPresented = false
  
  init() {
    updatePracticeState()
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        // Background
        BackgroundView()
        
        
        VStack (alignment: .leading) {
          
          // Greeting with custom user name
          GreetingView()
          
          // MARK: Section: Dashboard
          HStack {
            
            // Headline, changes dinamically on what date range the user selects for the dashboard
            HeadlineView(filterLogic: $filterLogic)
            
            Spacer()
            
            // MARK: Dashboard Settings
            /// User can define a date range and choose between what pilot function and launch method to display data from
            Menu {
              
              Text("Configure Your Dashboard")
              
              // Configure Date Range for Dashboard
              Menu {
                Button("Total") { filterLogic = FilterLogic.total }
                Button("Last Six Months") { filterLogic = FilterLogic.lastSixMonths }
                Button("This Year") { filterLogic = FilterLogic.thisYear }
                Button("Last Year") { filterLogic = FilterLogic.lastYear }
              } label: {
                Label("Set Date Range", systemImage: "calendar")
              }
              
              // Configure what Function Time to display
              Menu {
                Button(action: { showFunctionTime = PilotFunctionTime.pic }) {
                  Label("PIC", systemImage: "person")}
                
                Button(action: { showFunctionTime = PilotFunctionTime.dual }) {
                  Label("Dual", systemImage: "person.2")}
                
                Button(action: { showFunctionTime = PilotFunctionTime.instructorAndPic }) {
                  Label("Instructor", systemImage: "graduationcap")}
              } label: {
                Label("Display Function Time", systemImage: "clock")
              }
              
              // Configure what Launch Method to display
              Menu {
                Button(action: { showDepartureMode = DepartureMode.winch }) {
                  Label("Winch", systemImage: "w.circle.fill")}
                
                Button(action: { showDepartureMode = DepartureMode.aerotow }) {
                  Label("Aerotow", systemImage: "a.circle.fill")}
                
                Button(action: {  showDepartureMode = DepartureMode.selfLaunching }) {
                  Label("Self Launching", systemImage: "s.circle.fill")}
                
              } label: {
                Label("Display Launch Method", systemImage: "airplane.departure")
              }
            } label: {
              Image(systemName: "slider.horizontal.3")
                .font(.system(size: 20))
                .opacity(0.4)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 20)
            .onTapGesture { HapticHelper.impact() }
            
          }
          .padding(.bottom, 27)
          
          
          // MARK: Stat Cards – Row 1
          HStack {
            Spacer()
            // Define date range
            let range = filterLogic.dateRange()
            // Stat Card Hours
            StatCardView(image: "clock",
                         number: flightDataInRange(startDate: range.start, endDate: range.end, isHours: true),
                         label: "Hours")
            Spacer()
            Spacer()
            // Stat Card Starts
            StatCardView(image: "airplane.departure",
                         number: flightDataInRange(startDate: range.start, endDate: range.end, isHours: false),
                         label: "Starts")
            Spacer()
          }
          .padding(.bottom, 29)
          
          
          // MARK: Stat Cards – Row 2
          HStack {
            Spacer()
            // Define date range
            let range = filterLogic.dateRange()
            // Stat Card Function Time
            StatCardFunctionTimeView(
              pilotFunctionTime: showFunctionTime,
              value: viewModel.flightTimeForFunction(
                flightLogs: flightLogs,
                selectedFunction: showFunctionTime,
                startDate: range.start,
                endDate: range.end))
            Spacer()
            Spacer()
            // Stat Card Departure Mode
            StatCardDepartureModeView(
              departureMode: showDepartureMode,
              value: viewModel.flightsForDepartureMode(
                flightLogs: flightLogs,
                departureMode: showDepartureMode,
                startDate: range.start,
                endDate: range.end))
            Spacer()
          }
          .padding(.bottom, 64)
          
          
          
          // MARK: Section: Practice State
          
          // Title
          Text("Your Practice State")
            .font(.subheadline)
            .bold()
          
          // Subtitle: Display 6 months date range
          Text(DateHelper.sixMonthsRange())
            .font(.subheadline)
            .fontWeight(.light)
            .padding(.bottom, 10)
            .opacity(0.6)
          
          
          HStack {
            
            // Stats Card: 6 Months Stats for Practice State
            let calendar = Calendar.current
            let endDate = Date()
            let startDate = calendar.date(byAdding: .month, value: -6, to: endDate)!
            
            HStack {
              VStack(alignment: .leading, spacing: 10) {
                Text(String(flightDataInRange(startDate: startDate, endDate: endDate, isHours: true).noDotZero))
                  .font(.system(size: 27, weight: .semibold))
                Text("\(Image(systemName: "clock")) Hours")
                  .font(.sectionHeadline)
                  .opacity(0.6)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              
              VStack(alignment: .leading, spacing: 10) {
                Text(String(flightDataInRange(startDate: startDate, endDate: endDate, isHours: false).noDotZero))
                  .font(.system(size: 27, weight: .semibold))
                Text("\(Image(systemName: "airplane.departure")) Starts")
                  .font(.sectionHeadline)
                  .opacity(0.6)
              }
            }
            
            .padding()
            .frame(width: 180, height: 100)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.08), radius: 7, x: 3, y: 4)
            
            Spacer()
            
            // Traffic Light showing practice state
            Menu {
              Text("The traffic light shows your practice state.")
            } label: {
              if isPracticeStateDetailed {
                TrafficLightDetailView(practiceState: $practiceStateDouble)
              } else {
                TrafficLightView(practiceState: $practiceState)
              }
            }
            
            Spacer()
            Spacer()
            
          }
        }
        .padding(.horizontal, 25)
        
        
        // Info sign with link to information material for user to understand practice state
        InfoSignView()
        
        
        // Navigation Buttons
        NavigationButtonsView(isSettingsPresented: $isSettingsPresented)
        
        
        // Show warning if app is using sample data
        SampleDataWarningView()
        
      }
      .ignoresSafeArea()
      .onAppear { updatePracticeState() }
      .sheet(isPresented: $isSettingsPresented, onDismiss: { updatePracticeState() }) { SettingsView() }
    }
  }
  
  
  private func updatePracticeState() {
    let calendar = Calendar.current
    let endDate = Date()
    let startDate = calendar.date(byAdding: .month, value: -6, to: endDate)!
    if isPracticeStateDetailed {
      practiceStateDouble = viewModel.calculatePracticeStateDouble(
        hours: flightDataInRange(startDate: startDate, endDate: endDate, isHours: true),
        starts: flightDataInRange(startDate: startDate, endDate: endDate, isHours: false))
    } else {
      practiceState = viewModel.calculatePracticeStateInt(
        hours: flightDataInRange(startDate: startDate, endDate: endDate, isHours: true),
        starts: flightDataInRange(startDate: startDate, endDate: endDate, isHours: false))
    }
  }
  
  private func flightDataInRange(startDate: Date, endDate: Date, isHours: Bool) -> Double {
    let filteredLogs = filterFlightLogs(startDate: startDate, endDate: endDate)
    
    if isHours {
      // Return Total Hours
      let totalSeconds = filteredLogs.reduce(0) { $0 + $1.flightTime }
      let totalHours = totalSeconds / 3600
      return round(totalHours * 10) / 10.0 // Round to one decimal place
    } else {
      // Return Total Number of Starts
      return Double(filteredLogs.count)
    }
  }
  
  func filterFlightLogs(startDate: Date, endDate: Date) -> [FlightLog] {
    return flightLogs.filter { flightLog in
      if let arrivalDate = flightLog.arrivalDate { return arrivalDate >= startDate && arrivalDate <= endDate }
      return false
    }
  }
}

#Preview {
  HomeView()
}
