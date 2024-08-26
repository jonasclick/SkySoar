//
//  SkySoarApp.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI
import SwiftData
import RevenueCat

@main
struct SkySoarApp: App {
    
    @AppStorage("onboarding") var needsOnboarding = true
    @StateObject var userViewModel = UserViewModel()

    init() {
        
        // Initialize RevenueCat (Framework for In-App-Purchases)
        Purchases.configure(withAPIKey: "appl_gQBzpmIoDOFUUNUhnHXBMITEfTU")
        
        // Set App Icon back to default if user has ended subscription
        userViewModel.checkAppIcon()
    }
    
    var body: some Scene {
        WindowGroup {
            
            // Check if user needs onboarding, else display HomeView
            if needsOnboarding {
                Onboarding1View()
                    .modelContainer(for: FlightLog.self)
            }
            else {
                HomeView()
                    .modelContainer(for: FlightLog.self)
                    .environmentObject(userViewModel)
            }
        }
    }
}
