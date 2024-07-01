//
//  InfoCardRedView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 24.06.2024.
//

import SwiftUI

struct InfoCardRedView: View {
    var body: some View {
        
        VStack (alignment: .leading) {
            // Info Card Title
            HStack {
                Image(systemName: "info.circle")
                    .bold()
                Text("For inexperienced pilots")
                    .font(.infoBoxHeadline)
            }
            .padding(.bottom, 10)
            
            
            // Info Card Text
            VStack (alignment: .leading) {
                HStack {
                    Text("""
                         Perform the first take-offs after a long break only with familiar aircraft models and in non-critical weather conditions.
                         
                         """)
                }
                HStack {
                    Text("""
                        If the last take-off was more than three months ago, training with a flight instructor is the best way to achieve a good practice level.
                        """)
                }
                .padding(.top, 2)
            }
            .font(.infoBoxContent)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.barometerRed)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 3, y: 4)
        .padding(.bottom, 40)
        
    }
}

#Preview {
    InfoCardRedView()
}
