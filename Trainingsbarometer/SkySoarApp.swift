//
//  SkySoarApp.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI
import RevenueCat

@main
struct SkySoarApp: App {
    
    init() {
        // Initialize RevenueCat (Framework for In-App-Purchases)
        Purchases.configure(withAPIKey: "appl_gQBzpmIoDOFUUNUhnHXBMITEfTU")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
