//
//  SettingsView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 25.06.2024.
//

import SwiftUI

struct SettingsView: View {
    
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
                    .padding(.bottom, localizedPadding())
                
                
                // Disclaimer Card, with different frame heights depending on localization
                DisclaimerCardView()
                    .padding(.horizontal)
                    .frame(height: localizedFrameHeight())
                    .onTapGesture {
                        isDisclaimerPresented.toggle()
                    }
                    .sheet(isPresented: $isDisclaimerPresented) {
                        DisclaimerView()
                            .presentationDetents([.fraction(0.6)])
                    }
                
                
                // Section "User Guide"
                Text("User Guide")
                    .font(.flightLogPrimary)
                    .padding(.top, localizedPadding())
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
                
                
                // Section "About"
                Text("About")
                    .font(.flightLogPrimary)
                    .padding(.top, 50)
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
    
    // Different frame height for DisclaimerCardView for Localizations EN and DE
    private func localizedFrameHeight() -> CGFloat {
        if let currentLanguage = Locale.current.language.languageCode?.identifier {
            if currentLanguage == "de" {
                return 180
            }
        }
        return 138
    }
    
    // Different padding for DisclaimerCardView for Localizations EN and DE
    private func localizedPadding() -> CGFloat {
        if let currentLanguage = Locale.current.language.languageCode?.identifier {
            if currentLanguage == "de" {
                return 30
            }
        }
        return 50
    }
    
    // Different Email URL for Localizations EN and DE
    private func localizedEmailURLString() -> String {
        if let currentLanguage = Locale.current.language.languageCode?.identifier {
            if currentLanguage == "de" {
                return "mailto:jonas@vetschmedia.com?subject=Rückmeldung%20Trainingsbarometer%20App&body=Liebes%20Entwicklerteam"
            }
        }
        return "mailto:jonas@vetschmedia.com?subject=Feedback%20Practice%20State%20Barometer%20App&body=Dear%20Developers"
    }
        
}

#Preview {
    SettingsView()
}
