//
//  StatView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI

struct StatCardView: View {
    
    var image: String
    var number: Double
    var label: String
    
    var body: some View {
        
        // Stat Card
        VStack (alignment: .leading) {
            Image(systemName: image)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.6)
            Spacer()
            Text(noDotZero(number))
                .font(.statNumber)
            Text(label)
                .font(.sectionHeadline)
                .opacity(0.6)
            
        }
        .padding()
        .frame(width: 130, height: 130)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 3, y: 4)
    }
    
    // Handle dispaly of decimal of the Double
    func noDotZero(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            // If the number is an integer, display without decimal
            return String(format: "%.0f", number)
        } else {
            // If the number has a fractional part, display one decimal
            return String(format: "%.1f", number)
        }
    }
}

#Preview {
    StatCardView(image: "clock", number: 23, label: "Stunden")
}
