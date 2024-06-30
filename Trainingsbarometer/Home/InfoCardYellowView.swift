//
//  InfoCardYellowView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 24.06.2024.
//

import SwiftUI

struct InfoCardYellowView: View {
    var body: some View {
        
        VStack (alignment: .leading) {
            // Info Card Title
            HStack {
                Image(systemName: "info.circle")
                    .bold()
                Text("Caution during takeoff")
                    .font(.infoBoxHeadline)
            }
            .padding(.bottom, 15)
            
            VStack (alignment: .leading) {
                // Info Card Text
                HStack {
                    Image(systemName: "chevron.forward")
                        .scaleEffect(0.7)
                    Text("in unfamiliar landscape regions (e.g. mountains)")
                }
                .padding(.bottom, 2)
                HStack {
                    Image(systemName: "chevron.forward")
                        .scaleEffect(0.7)
                    Text("at unfamiliar airfields")
                }
                .padding(.bottom, 2)
                HStack {
                    Image(systemName: "chevron.forward")
                        .scaleEffect(0.7)
                    Text("on rarely flown glider models")
                }
                .padding(.bottom, 2)
                HStack {
                    Image(systemName: "chevron.forward")
                        .scaleEffect(0.7)
                    Text("in a rarely performed launch method")
                }
            }
            .padding(.leading, 5)
            .font(.infoBoxContent)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.barometerYellow)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 3, y: 4)
        .padding(.bottom, 40)
        
    }
}

#Preview {
    InfoCardYellowView()
}
