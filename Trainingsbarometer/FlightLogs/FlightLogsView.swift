//
//  FlightLogsView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI
import SwiftData

struct FlightLogsView: View {
    
    @Query private var flightLogs: [FlightLog]

    var body: some View {
        List {
            ForEach(flightLogs) { f in
                Text("Test")
            }
        }
    }
}

#Preview {
    FlightLogsView()
}
