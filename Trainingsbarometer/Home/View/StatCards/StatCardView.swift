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
    var label: LocalizedStringKey
    
    var body: some View {
        
        // Stat Card
        VStack (alignment: .leading) {
            Image(systemName: image)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.6)
            Spacer()
            Text(number.noDotZero)
                .font(.statNumber)
            Text(label)
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
    StatCardView(image: "clock", number: 23, label: "Hours")
}
