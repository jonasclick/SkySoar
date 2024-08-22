//
//  InfoSignView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 20.08.2024.
//

import SwiftUI

struct InfoSignView: View {
    
    let url: String = "https://www.daec.de/media/files/2023/Sportarten/Segelflug/Downloads/DAeC-Trainingbarometer_A3-Plakat_RZ_Druck_a.pdf"
    
    var body: some View {
        
        HStack {
            Spacer()
            VStack {
                Spacer()
                ZStack {
                    
                    // Thin Connecting Lines
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundStyle(.trafficLightGray)
                        .frame(width: 2, height: 12)
                    
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundStyle(.trafficLightGray)
                        .frame(width: 2, height: 12)
                        .offset(x: 25)
                    
                    // Horizontal Pole
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.trafficLightGray)
                        .frame(width: 69, height: 6)
                        .offset(x: 20, y: -8)
                    
                    // Sign
                    Link(destination: URL(string: url)!, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.trafficLightGray)
                                .frame(width: 45, height: 38)
                            Image(systemName: "info.circle")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .offset(x: 13, y: 25)
                    })
                }
                .shadow(color: .black.opacity(0.3), radius: 7, x: 3, y: 4)
                .padding(.trailing, 17)
                .padding(.bottom, 140)
            }
        }
    }
}

#Preview {
    InfoSignView()
}
