//
//  DisclaimerCardView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 30.06.2024.
//

import SwiftUI

struct DisclaimerCardView: View {
    var body: some View {
        ZStack {
            
            
            Rectangle()
                .foregroundStyle(Color.disclaimerGray)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            
            VStack (alignment: .leading) {
                
                // Title
                HStack {
                    Image(systemName: "exclamationmark.shield.fill")
                        .font(.system(size: 18))
                        .opacity(0.7)
                    Text("Disclaimer")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom, 5)
                
                // Body
                Text("Do not rely solely on the information of this application.")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.infoBoxContent)
                    .padding(.bottom, 2)
                Text("Verify all information independently, as data may be incorrect.")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.infoBoxContent)
                    .tracking(-0.3)
                    .padding(.bottom, 2)
                Text("The developers disclaim any liability.")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.infoBoxContent)
                    .padding(.bottom, 2)
                
                // "Read the full disclaimer"
                HStack {
                    Spacer()
                    Text("Read the full disclaimer")
                        .fontWeight(.medium)
                    Image(systemName: "arrow.right.circle")
                }
                .font(.system(size: 14))
                .padding(.top, 5)
            }
            .padding()
            
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    DisclaimerCardView()
}
