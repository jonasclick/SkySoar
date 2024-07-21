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
                        showSampleDataAlert.toggle()
                    }
                    .alert(isSampleData ? "Sample Flights Added" : "Sample Flights Removed", isPresented: $showSampleDataAlert, actions: {
                        Button {
                            toggleSampleData()
                            dismiss()
                        } label: {
                            Text(isSampleData ? "I understand: It's not my training state" : "OK")
                                .foregroundStyle(Color.red)
                                .bold()
                        }}, message: {
                            Text(isSampleData ? "\nTen sample flights have been added. Therefore: Do not mistake the training state shown in the app with your own training state!" : "\nAll sample flights have been removed. Double check your flight data before trusting the indicated practice state.")
                        })
                
                
                
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
    
    private func toggleSampleData() {
        
        if !isSampleData {
            
            // Add 10 sample flights to the context
            SampleDataHelper.addSampleData(context: context)
        }
        
        if isSampleData {
            deleteSampleData()
        }
    }
    
    // Different Email URL for Localizations EN and DE
    private func localizedEmailURLString() -> String {
        return (Locale.current.language.languageCode?.identifier ?? "") == "de" ?
        "mailto:jonas@vetschmedia.com?subject=Rückmeldung%20Trainingsbarometer%20App&body=Liebes%20Entwicklerteam" :
        "mailto:jonas@vetschmedia.com?subject=Feedback%20Practice%20State%20Barometer%20App&body=Dear%20Developers"
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
