//
//  TrafficLightDetailView.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 03.05.2025.
//

import SwiftUI

import SwiftUI

struct TrafficLightDetailView: View {
  
  @Binding var practiceState: Double
  
  var body: some View {
    ZStack {
      
      
      // MARK: Traffic Light Structure
      // Pole
      RoundedRectangle(cornerRadius: 0)
        .foregroundStyle(.trafficLightGray)
        .frame(width: 17, height: 140)
        .offset(y: 128)
      
//      // Background around the lights
//      RoundedRectangle(cornerRadius: 10)
//        .foregroundStyle(.trafficLightGray)
//        .frame(width: 48, height: 116)
      
      
      // MARK: Lights
      PracticeStateGraph(practiceState: practiceState)
        .scaleEffect(0.8)
      
    }
    .shadow(color: .black.opacity(0.3), radius: 7, x: 3, y: 4)
  }
}

#Preview {
  TrafficLightDetailView(practiceState: .constant(2.55))
}
