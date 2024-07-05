//
//  SettingsView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 25.06.2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var flightLogs: [FlightLog]
    
    private var isSampleData: Bool {SampleDataHelper.initializeIsSampleData(from: flightLogs)}
    
    @State private var showSampleDataAlert = false
    @State private var isDisclaimerPresented = false
    @State private var isExplainerPresented = false
    @State private var isCopyrightPresented = false
    @State private var isGitHubPresented = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack (alignment: .leading) {
                
                
                // Title
                Text("Settings")
                    .font(.mainHeadline)
                    .padding(.top, 40)
                    .padding(.horizontal)
                    .padding(.bottom, (Locale.current.language.languageCode?.identifier ?? "") == "de" ? 30 : 50)
                
                
                // Disclaimer Card, with different frame heights depending on localization
                DisclaimerCardView()
                    .padding(.horizontal)
                    .frame(height: (Locale.current.language.languageCode?.identifier ?? "") == "de" ? 180 : 138)
                    .onTapGesture {
                        isDisclaimerPresented.toggle()
                    }
                    .sheet(isPresented: $isDisclaimerPresented) {
                        DisclaimerView()
                            .presentationDetents([.fraction(0.7)])
                    }
                
                
                // Section "User Guide"
                Text("User Guide")
                    .font(.flightLogPrimary)
                    .padding(.top, (Locale.current.language.languageCode?.identifier ?? "") == "de" ? 30 : 50)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                // Why use Pilot Practice Barometer?
                SettingsCardView(icon: "thermometer.medium", text: "Why should I use Pilot Practice Barometer?")
                    .onTapGesture {
                        isExplainerPresented.toggle()
                    }
                    .sheet(isPresented: $isExplainerPresented) {
                        ExplainerVideoView()
                    }
                
                // Toggle Sample Data
                SettingsCardView(icon: "tray.and.arrow.\(isSampleData ? "up" : "down")", text: isSampleData ? "Remove sample flights to start using the app" : "Add sample flight logs to explore the app")
                    .onTapGesture {
                        toggleSampleData()
                    }
                    .alert(isPresented: $showSampleDataAlert) {
                        Alert(
                            title: Text(isSampleData ? "Sample Flights Added" : "Sample Flights Removed"),
                            message: Text(isSampleData ? "\nTen sample flights have been added. Therefore: Do not mistake the training state shown in the app with your own training state!" : "\nAll sample flights have been removed. Double check your flight data before trusting the indicated practice state."),
                            dismissButton: .destructive(Text(isSampleData ? "I understand: It's not my training state" : "OK")) {
                                dismiss() // Close settings sheet after adding / removing sample data
                            }
                        )
                    }
                
                // Section "About"
                Text("About")
                    .font(.flightLogPrimary)
                    .padding(.top, 30)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                // Copyright
                SettingsCardView(icon: "c.circle", text: "Copyright")
                    .onTapGesture {
                        isCopyrightPresented.toggle()
                    }
                    .sheet(isPresented: $isCopyrightPresented) {
                        CopyrightView()
                            .presentationDetents([.fraction(0.7)])
                    }
                
                // Request a feature / report bug
                Link(destination: URL(string: localizedEmailURLString())!, label: {
                    SettingsCardView(icon: "lightbulb.max", text: "Request a feature or report a bug")
                        .foregroundStyle(.black)
                })
                
                
                // Link to Github Page Link (custom image)
                ZStack {
                    Rectangle()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .foregroundStyle(.white)
                        .shadow(radius: 5, x: 2, y: 4)
                    HStack {
                        Image("github logo")
                            .frame(width: 11)
                            .padding(.trailing, 5)
                        Text("About this project and how to contribute")
                        Spacer()
                    }
                    .padding(.horizontal)
                    .font(.flightLogSecondary)
                }
                .padding(.horizontal)
                .frame(height: 41)
                .onTapGesture {
                    isGitHubPresented.toggle()
                }
                .sheet(isPresented: $isGitHubPresented) {
                    WebsiteView(title: "About this App", url: "https://github.com/jonasclick/Trainingsbarometer")
                }
                
                
                // Display Version Number
                HStack {
                    Spacer()
                    Text("v1.0.0")
                        .padding(.horizontal)
                        .font(.infoBoxContent)
                        .opacity(0.5)
                        .padding(.top, 5)
                }
                
                
                Spacer()
            }
            
            // Close Button Top Right of Sheet
            CloseButtonView()
            
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true) // Hide default back button coming from NavigationLink in HomeView
    }
    
    func toggleSampleData() {
        
        if !isSampleData {
            
            // 1
            addFlightLog(departureD: setDateTime(dayOffset: -1, hour: 11, minute: 4), arrivalD: setDateTime(dayOffset: -1, hour: 14, minute: 44), flightTime: 13260, departureM: DepartureMode.aerotow)
            // 2
            addFlightLog(departureD: setDateTime(dayOffset: -14, hour: 10, minute: 37), arrivalD: setDateTime(dayOffset: -14, hour: 10, minute: 44), flightTime: 420, departureM: DepartureMode.winch)
            // 3
            addFlightLog(departureD: setDateTime(dayOffset: -14, hour: 11, minute: 14), arrivalD: setDateTime(dayOffset: -14, hour: 14, minute: 26), flightTime: 11520, departureM: DepartureMode.winch)
            // 4
            addFlightLog(departureD: setDateTime(dayOffset: -30, hour: 10, minute: 34), arrivalD: setDateTime(dayOffset: -30, hour: 15, minute: 05), flightTime: 16260, departureM: DepartureMode.winch)
            // 5
            addFlightLog(departureD: setDateTime(dayOffset: -44, hour: 11, minute: 03), arrivalD: setDateTime(dayOffset: -44, hour: 17, minute: 17), flightTime: 22440, departureM: DepartureMode.selfLaunching)
            // 6
            addFlightLog(departureD: setDateTime(dayOffset: -60, hour: 10, minute: 20), arrivalL: "Grenchen", arrivalD: setDateTime(dayOffset: -60, hour: 12, minute: 34), flightTime: 8040, departureM: DepartureMode.aerotow)
            // 7
            addFlightLog(departureL: "Grenchen", departureD: setDateTime(dayOffset: -60, hour: 14, minute: 33), arrivalD: setDateTime(dayOffset: -60, hour: 16, minute: 24), flightTime: 6660, departureM: DepartureMode.aerotow)
            // 8
            addFlightLog(departureL: "Amlikon", departureD: setDateTime(dayOffset: -74, hour: 11, minute: 15), arrivalL: "Amlikon", arrivalD: setDateTime(dayOffset: -74, hour: 12, minute: 33), flightTime: 4680, departureM: DepartureMode.winch)
            // 9
            addFlightLog(departureL: "Amlikon", departureD: setDateTime(dayOffset: -74, hour: 15, minute: 43), arrivalL: "Amlikon", arrivalD: setDateTime(dayOffset: -74, hour: 16, minute: 46), flightTime: 3720, departureM: DepartureMode.winch)
            // 10
            addFlightLog(departureD: setDateTime(dayOffset: -90, hour: 9, minute: 47), arrivalD: setDateTime(dayOffset: -90, hour: 10, minute: 46), flightTime: 3540, departureM: DepartureMode.aerotow)
        }
        
        if isSampleData {
            deleteSampleData()
        }
        
        showSampleDataAlert.toggle()
    }
    
    // Different Email URL for Localizations EN and DE
    private func localizedEmailURLString() -> String {
        return (Locale.current.language.languageCode?.identifier ?? "") == "de" ?
                "mailto:jonas@vetschmedia.com?subject=Rückmeldung%20Trainingsbarometer%20App&body=Liebes%20Entwicklerteam" :
                "mailto:jonas@vetschmedia.com?subject=Feedback%20Practice%20State%20Barometer%20App&body=Dear%20Developers"
    }
    
    // Helper to add samlpe data helper function to add flight data with a Date in relation to the creation date of the flight data.
    private func setDateTime(dayOffset: Int, hour: Int, minute: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        
        var date = Calendar.current.date(from: components)!
        
        if dayOffset != 0 {
            date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date)!
        }
        
        return date
    }
    
    // Add sample flight log, some default values are defined
    private func addFlightLog(departureL: String = "Mollis", departureD: Date, arrivalL: String = "Mollis", arrivalD: Date, flightTime: TimeInterval, departureM: DepartureMode = DepartureMode.aerotow) {
        
        let flightLog = FlightLog()
        
        flightLog.isSampleData = true
        
        flightLog.departureLocation = departureL
        flightLog.departureDate = departureD
        
        flightLog.arrivalLocation = arrivalL
        flightLog.arrivalDate = arrivalD
        
        flightLog.aircraftModel = "Arcus M"
        flightLog.aircraftRegistration = "HB-1234"
        
        flightLog.flightTime = flightTime
        
        flightLog.departureMode = departureM
        flightLog.pilotFunctionTime = PilotFunctionTime.pic
        
        flightLog.remarks = (Locale.current.language.languageCode?.identifier ?? "") == "de" ? "Achtung: Beispiel-Flug" : "Caution: Sample flight"
        
        context.insert(flightLog)
    }
    
    // Delete all sample flight data
    private func deleteSampleData() {
        for flightLog in flightLogs {
            if flightLog.isSampleData {
                context.delete(flightLog)
            }
        }
    }
    
}

#Preview {
    SettingsView()
}
