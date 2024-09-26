//
//  StatCardDepartureModeView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 20.08.2024.
//

import SwiftUI

struct StatCardDepartureModeView: View {
    
    var departureMode: DepartureMode
    var value: Int
    
    var body: some View {
        
        // Stat Card
        VStack (alignment: .leading) {
            Image(systemName: departureMode.sfSymbol())
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.6)
            Spacer()
            Text(String(value))
                .font(.statNumber)
            Text(departureMode.labelEN())
                .font(.sectionHeadline)
                .opacity(0.6)
            
        }
        .padding()
        .frame(width: 130, height: 130)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.08), radius: 7, x: 3, y: 4)
    }
    
}

#Preview {
    StatCardDepartureModeView(departureMode: DepartureMode.winch, value: 12)
}
