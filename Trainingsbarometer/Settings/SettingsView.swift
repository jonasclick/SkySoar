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
    
    @AppStorage("Username") var userName: String = ""
    
    @Query private var flightLogs: [FlightLog]
    
    private var isSampleData: Bool {SampleDataHelper.initializeIsSampleData(from: flightLogs)}
    
    @State private var isDisclaimerPresented = false
    @State private var isEditingUsername = false
    @State private var usernameInput = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var showSampleDataAlert = false
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
                
                
                // MARK: Disclaimer Card
                DisclaimerCardView()
                    .onTapGesture {
                        isDisclaimerPresented.toggle()
                        HapticHelper.impact()
                    }
                    .sheet(isPresented: $isDisclaimerPresented) {
                        DisclaimerView()
                            .presentationDetents([.fraction(0.7)])
                    }
                
                
                // MARK: Section: General
                Text("General")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.top, (Locale.current.language.languageCode?.identifier ?? "") == "de" ? 30 : 50)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                
                // MARK: Change Username
                if !isEditingUsername {
                    SettingsCardView(icon: "person", text: "Change name for greeting on home screen")
                        .onTapGesture {
                            isEditingUsername = true
                            isTextFieldFocused = true
                        }
                }
                else {
                    // Change Username Input field and save button
                    ZStack {
                        Rectangle()
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .foregroundStyle(.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 2, y: 4)
                        HStack {
                            Image(systemName: "person")
                                .frame(width: 11)
                                .padding(.trailing, 5)
                            TextField("Enter your name", text: $usernameInput)
                                .focused($isTextFieldFocused)
                            Spacer()
                            Button("Save") {
                                HapticHelper.success()
                                userName = usernameInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "" : String(", " + usernameInput)
                                isEditingUsername = false
                                dismiss()
                            }
                        }
                        .padding(.horizontal)
                        .font(.flightLogSecondary)
                    }
                    .padding(.horizontal)
                    .frame(height: 41)
                    .padding(.bottom, -2)
                }
                
                
                // MARK: Toggle Sample Data
                SettingsCardView(icon: "tray.and.arrow.\(isSampleData ? "up" : "down")", text: isSampleData ? "Remove sample flights to start using the app" : "Add sample flights to explore the app")
                    .onTapGesture {
                        showSampleDataAlert.toggle()
                        HapticHelper.warning()
                    }
                    .alert(!isSampleData ? "Sample Flights Added" : "Sample Flights Removed", isPresented: $showSampleDataAlert, actions: {
                        Button {
                            toggleSampleData()
                            dismiss()
                        } label: {
                            Text(!isSampleData ? "I understand: It's not my training state" : "OK")
                                .foregroundStyle(Color.red)
                                .bold()
                        }}, message: {
                            Text(!isSampleData ? "\nTen sample flights have been added. Therefore do not mistake the training state shown in the app with your own training state!" : "\nAll sample flights have been removed. Double check your flight data before trusting the indicated practice state.")
                        })
                // Info: Logic of the alert needs to be inverted (!isSampleData), as sample data is only added after confirming the alert.
                
                
                // MARK: Section: "About"
                Text("About SkySoar")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.top, 30)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                
                // MARK: Request feature, report bug
                Link(destination: URL(string: localizedEmailURLString())!, label: {
                    SettingsCardView(icon: "lightbulb.max", text: "Request a feature or report a bug") })
                .buttonStyle(PlainButtonStyle())
                .simultaneousGesture(TapGesture().onEnded { HapticHelper.impact() })
                
                
                // TODO: Donation Link?
                
                // MARK: Link to GitHub Page
                ZStack {
                    Rectangle()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .foregroundStyle(.white)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 2, y: 4)
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
                    Text("v1.0.1")
                        .padding(.horizontal)
                        .font(.caption2)
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
        // Add 10 sample flights to the context
        if !isSampleData { SampleDataHelper.addSampleData(context: context) }
        
        // Remove all sample flights
        if isSampleData { deleteSampleData() }
    }
    
    // Different Email URL for Localizations EN and DE
    private func localizedEmailURLString() -> String {
        return (Locale.current.language.languageCode?.identifier ?? "") == "de" ?
        "mailto:jonas@vetschmedia.com?subject=Rückmeldung SkySoar App&body=Liebes Entwicklerteam" :
        "mailto:jonas@vetschmedia.com?subject=Feedback%20SkySoar%20App&body=Dear%20Developers"
    }
    
    // Delete all sample flight data
    private func deleteSampleData() {
        for flightLog in flightLogs {
            if flightLog.isSampleData { context.delete(flightLog) }
        }
    }
}

#Preview {
    SettingsView()
}
