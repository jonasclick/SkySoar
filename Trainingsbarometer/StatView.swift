//
//  StatView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI

struct StatView: View {
    
    var image: String
    var number: Int
    var label: String
    
    var body: some View {
        // Stat Hours
        VStack (alignment: .leading) {
            Image(systemName: image)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(String(number))
                .font(.statNumber)
            Text(label)
                .font(.sectionHeadline)
            
        }
        .padding()
        .frame(width: 130, height: 130)
        .background(Color.barometerGreen)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 7, x: 3, y: 4) // Shadow doesn't match the design yet?
    }
}

#Preview {
    StatView(image: "clock", number: 23, label: "Stunden")
}
