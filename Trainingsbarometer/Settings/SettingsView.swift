//
//  SettingsView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 25.06.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var settingsIsPresented = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack (alignment: .leading) {
                
                
                
                // Title
                Text("Settings")
                    .font(.mainHeadline)
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .padding(.bottom, 23)
                
                // Disclaimer Card
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.disclaimerGray)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "exclamationmark.shield.fill")
                                .opacity(0.7)
                            Text("Disclaimer")
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                        }
                        .padding(.bottom, 5)
                        
                        Text("Do not rely solely on the information of this application.")
                            .font(.infoBoxContent)
                            .padding(.bottom, 2)
                        Text("Verify all information independently, as data may be incorrect.")
                            .font(.infoBoxContent)
                            .tracking(-0.3)
                            .padding(.bottom, 2)
                        Text("The developers disclaim any liability.")
                            .font(.infoBoxContent)
                            .padding(.bottom, 2)
                        HStack {
                            Spacer()
                            Text("Read the full disclaimer")
                            Image(systemName: "arrow.right.circle")
                        }
                        .font(.system(size: 14))
                        .padding(.top, 5)
                    }
                    .padding()
                }
                .padding(.horizontal)
                .frame(height: 138)
                .onTapGesture {
                    // TODO: Show full disclaimer sheet
                }
                
                
                // Section "User Guide"
                Text("User Guide")
                    .font(.flightLogPrimary)
                    .padding(.top, 36)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                SettingsCardView(icon: "thermometer.medium", text: "Why should I use a Flight Practice Barometer?")
                SettingsCardView(icon: "book", text: "How this application works")

                
                
                
                // Section "Export Flight Log Data"
                Text("Export Flight Log Data")
                    .font(.flightLogPrimary)
                    .padding(.top, 30)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                SettingsCardView(icon: "square.and.arrow.up", text: "Export flight logs data")

                // No SettingsCardView because of custom placement of icon
                ZStack {
                    Rectangle()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .foregroundStyle(.white)
                        .shadow(radius: 5, x: 2, y: 4)
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                            .frame(width: 11)
                            .padding(.trailing, 5)
                            .padding(.bottom, 2)
                        Text("Import flight logs data")
                        Spacer()
                    }
                    .padding(.horizontal)
                    .font(.flightLogSecondary)
                }
                .padding(.horizontal)
                .frame(height: 41)
                
                
                
                
                // Section "About"
                Text("About")
                    .font(.flightLogPrimary)
                    .padding(.top, 30)
                    .padding(.horizontal, 28)
                    .padding(.bottom, -3)
                
                SettingsCardView(icon: "c.circle", text: "Copyright")
                SettingsCardView(icon: "lightbulb.max", text: "Request a feature or report a bug")

                // No SettingsCardView because of custom image
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
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("close button")
                            .padding(.vertical, 15)
                            .padding(.horizontal, 8)
                    })
                }
                Spacer()
            }
            
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true) // Hides the default back button from NavigationLink in HomeView
        // Disclaimer Sheet
//        .sheet(isPresented: $settingsIsPresented) {
////            SettingsView()
//        }
        // Copyright Sheet
    }
}

#Preview {
    SettingsView()
}
