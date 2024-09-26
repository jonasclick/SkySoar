//
//  TrafficLightView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 20.08.2024.
//

import SwiftUI

struct TrafficLightView: View {
    
    @Binding var trainingState: Int
    
    var body: some View {
        ZStack {
            
            
            // MARK: Traffic Light Structure
            // Pole
            RoundedRectangle(cornerRadius: 0)
                .foregroundStyle(.trafficLightGray)
                .frame(width: 17, height: 140)
                .offset(y: 128)
            
            // Background around the lights
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.trafficLightGray)
                .frame(width: 48, height: 116)
            
            
            // MARK: Lights
            VStack {
                // Red Light
                Circle()
                    .foregroundStyle(.barometerRed)
                    .opacity(trainingState == 1 ? 1 : 0.2)
                // Yellow Light
                Circle()
                    .foregroundStyle(.barometerYellow)
                    .opacity(trainingState == 2 ? 1 : 0.2)
                // Green Light
                Circle()
                    .foregroundStyle(.barometerGreen)
                    .opacity(trainingState == 3 ? 1 : 0.2)
            }
            .frame(width: 28)
        }
        .shadow(color: .black.opacity(0.3), radius: 7, x: 3, y: 4)
    }
}

#Preview {
    TrafficLightView(trainingState: .constant(3))
}
