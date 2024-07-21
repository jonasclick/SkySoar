//
//  TrainingsbarometerApp.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI
import SwiftData

@main
struct TrainingsbarometerApp: App {
    
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            
            if needsOnboarding {
                Onboarding1View()
            }
            else {
                HomeView()
                    .modelContainer(for: FlightLog.self)
            }
        }
    }
}
