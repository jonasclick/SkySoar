//
//  Onboarding1View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 07.07.2024.
//

import SwiftUI

struct Onboarding1View: View {
    
//    @Binding var isOnboardingCompleted: Bool
    
    var body: some View {
        NavigationStack {
            
            HStack {
                // Title "Onboarding"
                Text("Onboarding")
                    .font(.mainHeadline)
                    .padding(.top, 40)
                    .padding(.horizontal)
                Spacer()
            }
            
            VStack (alignment: .center) {
                
                
                Spacer()
                
                // Speaker symbol
                Image(systemName: "speaker.wave.2.fill")
                    .font(.system(size: 22))
                    .opacity(0.7)
                    .padding(.bottom, 10)
                
                // Info Text
                Text("For the best onboarding experience,\nplease turn on your sound.")
                    .font(.flightLogSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 60)
                
                // Button "Continue" to next onboarding step
                NavigationLink (destination: {
                    Onboarding2View()
                }, label: {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                    .font(.flightLogSecondary)
                })
                .buttonStyle(PlainButtonStyle())

                
                Spacer()
                Spacer()
                
            }
            .padding()
            
            Spacer()
        }
    }
}

//#Preview {
//    Onboarding1View()
//}
