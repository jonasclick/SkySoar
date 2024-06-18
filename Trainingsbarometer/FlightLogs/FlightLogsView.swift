//
//  FlightLogsView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI
import SwiftData

struct FlightLogsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Query private var flightLogs: [FlightLog]
    @State private var newFlightLog: FlightLog?
    
    var body: some View {
        
        
        ZStack {
            Color.washedGreen
            
            Rectangle()
                .foregroundStyle(Color.washedGreen)
                .frame(width: 783, height: 347)
                .position(x: 200, y: 398)
                .rotationEffect(Angle(degrees: -36.57))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: -5, y: -5)
            
            
            Rectangle()
                .foregroundStyle(Color.washedGreen)
                .frame(width: 783, height: 347)
                .position(x: 200, y: 720)
                .rotationEffect(Angle(degrees: -36.57))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: -5, y: -5)
            
            
            VStack (alignment: .leading) {
                
                Text("Flights")
                    .font(.mainHeadline)
                    .padding(.top, 80)
                    .padding(.horizontal)
                
                // Flight Logs List
                ScrollView {
                    LazyVStack {
                        ForEach(flightLogs, id: \.self) { f in
                            FlightLogCardView(flightLog: f)
                        }
                    }
                    .padding(.top)
                }
            }
            
            
            // Navigation Buttons
            VStack (alignment: .trailing) {
                Spacer()
                HStack {
                    // Back Button
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 25))
                        }
                    }
                    Spacer()
                    // Add FlightLog Button
                    Button(action: {
                        // Create an empty FlighLog
                        self.newFlightLog = FlightLog()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30))
                    })
                }
                .buttonStyle(PlainButtonStyle())
                .padding(35)
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true) // Hide the default back button from NavigationLink in HomeView
        .sheet(item: $newFlightLog) { flightlog in
            AddFlightLogView(flightLog: flightlog)
        }
    }
}

#Preview {
    FlightLogsView()
}
