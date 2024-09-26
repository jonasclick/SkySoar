//
//  SettingsView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 25.06.2024.
//

import SwiftUI
import SwiftData
import RevenueCat
import RevenueCatUI

struct SettingsView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userViewModel: UserViewModel
    
    @ObservedObject private var viewModel = SettingsViewModel()
    
    @AppStorage("Username") var userName: String = ""
    
    @Query private var flightLogs: [FlightLog]
    
    private var isSampleData: Bool {SampleDataHelper.initializeIsSampleData(from: flightLogs)}
    
    @State private var isDisclaimerPresented = false
    @State private var isEditingUsername = false
    @State private var usernameInput = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var showSampleDataAlert = false
    
    @State private var showShareSheet = false
    @State private var shareURL: URL?
    
    @State private var showDocumentPicker = false
    @State private var showImportSuccessAlert = false
    @State private var showImportErrorAlert = false
    
    
    @State private var isSubscriptionPresented = false
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
                    .padding(.bottom, (Locale.current.language.languageCode?.identifier ?? "") == "de" ? 10 : 20)
                
                
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
                
                
                // MARK: – Section: General
                Text("General")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.top, (Locale.current.language.languageCode?.identifier ?? "") == "de" ? 10 : 20)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                
                // MARK: Change Username
                if !isEditingUsername {
                    SettingsCardView(icon: "person",
                                     text: "Change name for greeting on home screen")
                    .onTapGesture {
                        HapticHelper.impact()
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
                                userName = usernameInput.trimmingCharacters(
                                    in: .whitespacesAndNewlines).isEmpty ? "" : String(", " + usernameInput)
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
                SettingsCardView(icon: "tray.and.arrow.\(isSampleData ? "up" : "down")", 
                                 text: isSampleData ? "Remove sample flights to start using the app" : "Add sample flights to explore the app")
                .onTapGesture {
                    showSampleDataAlert.toggle()
                    HapticHelper.warning()
                }
                // Inform the user how to safely use sample data
                /// Info: Logic of the alert needs to be inverted (!isSampleData), as sample data is only added after confirming the alert.
                .alert(!isSampleData ? "Sample Flights Added" : "Sample Flights Removed",
                       isPresented: $showSampleDataAlert,
                       actions: {
                    Button {
                        toggleSampleData()
                        dismiss()
                    } label: {
                        Text(!isSampleData ? "I understand: It's not my practice state" : "OK")
                            .foregroundStyle(Color.red)
                            .bold()
                    }}, message: {
                        Text(!isSampleData ? "\nTen sample flights have been added. Therefore do not mistake the practice state shown in the app with your own practice state!" : "\nAll sample flights have been removed. Double check your flight data before trusting the indicated practice state.")
                    })
                
                
                // MARK: – Section: Import / Export Flight Data
                Text("Export and import flight logs")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.top, 20)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                // MARK: Export Flight Data
                SettingsCardView(icon: "square.and.arrow.up.on.square", text: "Export Flight Data")
                    .onTapGesture {
                        HapticHelper.impact()
                        
                        // Export Flight Data to JSON and present sheet for sharing
                        viewModel.exportFlightLogsToJSON(flightLogs: flightLogs) { url in
                            if let url = url {
                                shareURL = url
                                showShareSheet = true
                            }
                        }
                    }
                
                // MARK: Import Flight Data
                SettingsCardView(icon: "square.and.arrow.down.on.square", text: "Import Flight Data")
                    .onTapGesture {
                        HapticHelper.impact()
                        
                        // Show Document Picker to let user select file for import
                        showDocumentPicker.toggle()
                    }
                // Success
                    .alert("Flights imported",
                           isPresented: $showImportSuccessAlert,
                           actions: {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }}, message: {
                            Text("Your flights have been imported successfully.")
                        })
                // Error
                    .alert("Import failed",
                           isPresented: $showImportErrorAlert,
                           actions: {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }}, message: {
                            Text("Your flights have not been imported due to an error while trying to read flight data in the file provided. If you need assistance, please contact the developer.")
                        })
                
                
                // MARK: – Section: About
                Text("About SkySoar")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.top, 20)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                
                // MARK: Subscription
                SettingsCardView(icon: "heart.fill", text: userViewModel.isSubscriptionActive ? "Thank you for supporting SkySoar" : "Support the development of SkySoar")
                    .onTapGesture {
                        isSubscriptionPresented = true
                        HapticHelper.impact()
                    }
                    .sheet(isPresented: $isSubscriptionPresented) { SubscriptionView() }
                
                
                
                
                // MARK: Request feature, report bug
                Link(destination: URL(string: viewModel.localizedEmailURLString())!, label: {
                    SettingsCardView(icon: "lightbulb.max", text: "Request a feature or report a bug") })
                .buttonStyle(PlainButtonStyle())
                .simultaneousGesture(TapGesture().onEnded { HapticHelper.impact() })
                
                
                
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
                    HapticHelper.impact()
                }
                .sheet(isPresented: $isGitHubPresented) {
                    WebsiteView(title: "About this App", url: "https://github.com/jonasclick/Trainingsbarometer")
                }
                
                
                // Display Version Number
                HStack {
                    Spacer()
                    Text("v1.1.0")
                        .padding(.horizontal)
                        .font(.caption2)
                        .opacity(0.5)
                        .padding(.top, 5)
                }
                
                Spacer()
            }
            // Export Data: Share Sheet
            .sheet(isPresented: $showShareSheet) {
                if let shareURL = shareURL {
                    ShareSheet(activityItems: [shareURL])
                }
            }
            // Import Data: Document Picker Sheet
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker(onPick: { fileURL in
                    
                    do {
                        try viewModel.decodeFlightLogsFromJSON(fileURL: fileURL) { flights in
                            for flight in flights {
                                context.insert(flight)
                            }
                        }
                        showImportSuccessAlert.toggle()
                    } catch {
                        print("DEBUG: Import failed with error: \(error.localizedDescription)")
                        showImportErrorAlert.toggle()
                    }
                    
                })
            }
            
            // Close Button Top Right of Sheet
            CloseButtonView()
        }
    }
    
    private func toggleSampleData() {
        // Add 10 sample flights to the context
        if !isSampleData { SampleDataHelper.addSampleData(context: context) }
        
        // Remove all sample flights
        if isSampleData { deleteSampleData() }
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
