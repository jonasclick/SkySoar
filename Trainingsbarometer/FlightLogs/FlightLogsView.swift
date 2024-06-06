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
    @State private var newFlightLog: FlightLog?

    var body: some View {
        NavigationStack {
            List {
                ForEach(flightLogs) { f in
                    Text("Test")
                }
            }
            
            Spacer()
            
            Button(action: {
                self.newFlightLog = FlightLog()
            }, label: {
                Image(systemName: "note.text.badge.plus")
            })
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(item: $newFlightLog) { _ in
            AddFlightLogView()
        }

    }
}

#Preview {
    FlightLogsView()
}
