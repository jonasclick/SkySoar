//
//  TrainingsbarometerApp.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI
import SwiftData
import RevenueCat

@main
struct TrainingsbarometerApp: App {
    
    @AppStorage("onboarding") var needsOnboarding = true
    
    init() {
        Purchases.configure(withAPIKey: "appl_gQBzpmIoDOFUUNUhnHXBMITEfTU")
//        Purchases.logLevel = .debug // for development purposes
        
        // Reset App Icon to default if user has ended subscription
        isUserSubscribed()
    }
    
    var body: some Scene {
        WindowGroup {
            
            if needsOnboarding {
                Onboarding1View()
                    .modelContainer(for: FlightLog.self)
            }
            else {
                HomeView()
                    .modelContainer(for: FlightLog.self)
            }
        }
    }
    
    func isUserSubscribed() {
        
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let customerInfo = customerInfo {
                if customerInfo.entitlements["Supporter"]?.isActive == true {
                    return
                } else {
                    UIApplication.shared.setAlternateIconName(nil) { (error) in
                        if let error = error {
                            print("Failed request to reset the app’s icon: \(error)")
                        }
                    }
                }
            } else if let error = error {
                print("Failed to fetch customer info: \(error.localizedDescription)")
                return
            }
        }
        
    }
}
