//
//  FlightLogCardView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 12.06.2024.
//

import SwiftUI

struct FlightLogCardView: View {
    var body: some View {
        // Flight Log Card
        VStack {
            HStack (spacing: 22) {
                
                VStack (alignment: .leading) {
                    Text("Langenthal")
                        .font(.flightLogPrimary)
                    Text("10:52 Uhr")
                        .font(.flightLogSecondary)
                        .opacity(0.7)
                }
                
                HStack (spacing: 0) {
                    Circle()
                        .frame(height: 5)
                    Rectangle()
                        .frame(height: 1)
                    Circle()
                        .frame(height: 5)
                }
                
                
                VStack (alignment: .leading) {
                    Text("Langenthal")
                        .font(.flightLogPrimary)
                    Text("10:52 Uhr")
                        .font(.flightLogSecondary)
                        .opacity(0.7)
                }
            }
            HStack {
                VStack (alignment: .leading, spacing: 7) {
                    Spacer()
                    HStack {
                        Text("HB-3400")
                            .font(.flightLogPrimary)
                        Text("DG-1000s")
                            .font(.flightLogSecondary)
                            .opacity(0.7)
                    }
                    Text("Lorem ipsum dolor sit amet...")
                        .font(.flightLogSecondary)
                        .opacity(0.7)
                }
                Spacer()
                VStack (alignment: .leading) {
                    Spacer()
                    Text("PIC")
                        .font(.flightLogSecondary)
                        .opacity(0.7)
                    Text("1 h 2 min")
                        .font(.flightLogPrimary)
                }
            }
        }
        .padding()
        .frame(width: 370, height: 124)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                print("test")
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            Button {
                print("test")
            } label: {
                Label("Edit", systemImage: "pencil")
            }
        }
    }
}

#Preview {
    FlightLogCardView()
}
