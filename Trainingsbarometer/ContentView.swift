//
//  ContentView.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 08.09.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @AppStorage("onboarding") var needsOnboarding = true
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        
        Group {
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
        .onAppear {
            userViewModel.checkAppIcon()
        }
        
    }
    
}

#Preview {
    ContentView()
}
