//
//  Onboarding1View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 07.07.2024.
//

import SwiftUI

struct Onboarding1View: View {
    var body: some View {
        NavigationStack {
            
            VStack (alignment: .center) {
                
                Spacer()
                
                // Speaker symbol
                Image(.launchScreenAppIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70)
                    .padding(.bottom, 20)
                
                // Info Text
                Text("Welcome \(Image(systemName: "heart.fill")) to SkySoar")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 60)
                
                Spacer()
                
                // Button "Continue" to next onboarding step
                NavigationLink (destination: {
                    Onboarding2View()
                }, label: {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                })
                .buttonStyle(PlainButtonStyle())

                Spacer()
                
            }
        }
    }
}

#Preview {
    Onboarding1View()
}
