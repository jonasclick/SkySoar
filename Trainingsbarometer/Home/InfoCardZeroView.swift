//
//  InfoCardZeroView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 04.08.2024.
//

import SwiftUI

struct InfoCardZeroView: View {
    
    @State private var isCopyrightPresented = false
    
    var body: some View {
        
        ZStack {
            
            VStack (alignment: .leading) {
                // Info Card Title
                HStack {
                    Image(systemName: "info.circle")
                        .bold()
                    Text("How is my practice state calculated?")
                        .font(.infoBoxHeadline)
                }
                .padding(.bottom, 10)
                
                
                // Info Card Text
                VStack (alignment: .leading, spacing: -5) {
                    HStack {
                        Text("""
                         The practice state for pilots is calculated using your flight data from the past six months.
                         
                         """)
                    }
                    HStack {
                        Text("""
                        Add your flights of the past six months to see your practice state. Navigate to the flights list by tapping on the list symbol (\(Image(systemName: "list.bullet"))) below.
                        """)
                    }
                    .padding(.top, 10)
                }
                .font(.infoBoxContent)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 160, alignment: .leading)
        .background(Color.disclaimerGray)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.18), radius: 7, x: 3, y: 4)
    }
}

#Preview {
    InfoCardZeroView()
}
