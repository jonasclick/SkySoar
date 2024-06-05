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
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: FlightLog.self)
        }
    }
}
