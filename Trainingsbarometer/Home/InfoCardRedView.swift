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
                Text("Für ungeübte Piloten gilt")
                    .font(.infoBoxHeadline)
            }
            .padding(.bottom, 10)
            
            
            // Info Card Text
            VStack (alignment: .leading) {
                HStack {
                    Text("""
                         Die ersten Starts nach einer längeren Pause nur mit vertrauten Mustern und bei unkritischen Wetterlagen durchführen.
                         
                         """)
                }
                HStack {
                    Text("""
                        Falls der letzte Start mehr als drei Monate zurück liegt, ist Training mit einem Fluglehrer der beste Weg zu einem guten Übungsstand.
                        """)
                }
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
