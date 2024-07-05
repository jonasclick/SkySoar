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
                HStack {
                    Image(systemName: "exclamationmark.shield.fill")
                        .font(.system(size: 18))
                        .opacity(0.7)
                    Text("Disclaimer")
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                }
                .padding(.bottom, 5)
                
                Text("Do not rely solely on the information of this application.")
                    .font(.infoBoxContent)
                    .padding(.bottom, 2)
                Text("Verify all information independently, as data may be incorrect.")
                    .font(.infoBoxContent)
                    .tracking(-0.3)
                    .padding(.bottom, 2)
                Text("The developers disclaim any liability.")
                    .font(.infoBoxContent)
                    .padding(.bottom, 2)
                HStack {
                    Spacer()
                    Text("Read the full disclaimer")
                    Image(systemName: "arrow.right.circle")
                }
                .font(.system(size: 14))
                .padding(.top, 5)
            }
            .padding()
            
            
        }
    }
}

#Preview {
    DisclaimerCardView()
}
