//
//  PracticeStateGraphView.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 03.05.2025.
//

import Foundation
import SwiftUI

struct PracticeStateGraph: View {
  let practiceState: Double
  
  var body: some View {
    
    ZStack {
      // Color Scale Background
      VStack(spacing: 0) {
        Color("Barometer Green")
        Color("Barometer Yellow")
        Color("Barometer Red")
      }
      .frame(width: 60, height: 150)
      .cornerRadius(10)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color("Traffic Light Gray"), lineWidth: 12)
      )
      
      // Current Practice State Marker
      Rectangle()
        .fill(Color("Traffic Light Gray"))
        .frame(width: 60, height: 4)
        .offset(y: offset(for: practiceState))
    }
    .frame(height: 150)
  }
  
  private func offset(for state: Double) -> CGFloat {
    // Invert: y = 0 is top; y = 150 is bottom
    let clamped = max(1.0, min(4.0, state))
    let normalized = (clamped - 1.0) / 3.0 // 0 (red/bottom) to 1 (green/top)
    let totalHeight: CGFloat = 150
    let y = totalHeight * CGFloat(1.0 - normalized)
    return y - totalHeight / 2
  }
}

#Preview {
  PracticeStateGraph(practiceState: 2.45)
}
