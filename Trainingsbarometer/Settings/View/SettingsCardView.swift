//
//  SettingsCardView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 25.06.2024.
//

import SwiftUI

struct SettingsCardView: View {
    
    var icon: String
    var text: LocalizedStringKey
    
    var body: some View {
        
        // Settings Card
        ZStack {
            
            // Background
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 2, y: 4)
            
            // Icon and Text
            HStack {
                Image(systemName: icon)
                    .frame(width: 11)
                    .padding(.trailing, 5)
                Text(text)
                Spacer()
            }
            .padding(.horizontal)
            .font(.flightLogSecondary)
        }
        .padding(.horizontal)
        .frame(height: 41)
        .padding(.bottom, -2)
        
        
    }
}

#Preview {
    SettingsCardView(icon: "thermometer.medium", text: "Why should I use Pilot Practice?")
}
