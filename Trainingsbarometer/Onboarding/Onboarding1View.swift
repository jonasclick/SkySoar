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
                
                // Privacy Information
                Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                    .imageScale(.large)
                    .font(.title2)
                    .opacity(0.8)
                
                Text("SkySoar stores all your data locally on your device. \nYour data stays offline and can't be accessed by anyone else.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .opacity(0.8)
                
                Spacer()
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
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    Onboarding1View()
}
