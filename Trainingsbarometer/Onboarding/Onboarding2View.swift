//
//  Onboarding2View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 05.07.2024.
//

import SwiftUI

struct Onboarding2View: View {
    
    @State private var navigateToNextView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack (alignment: .center) {
                    
                    // Title "Onboarding"
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Onboarding")
                                .font(.mainHeadline)
                            Text("What is the Pilot Practice Barometer app for?")
                                .font(.infoBoxContent)
                                .opacity(0.8)
                                .padding(.top, -10)
                        }
                        .frame(idealWidth: .infinity)
                        .padding()
                        
                        Spacer()
                    }
                    
                    // Onboarding Video
                    if let localVideoURL = Bundle.main.url(forResource: "OnboardingVideov2", withExtension: "mov") {
                        
                            VideoPlayerView(videoURL: localVideoURL)
                            .aspectRatio(9/16, contentMode: .fit)
                            .frame(height: 550)
                        
                    } else {
                        Text("We're sorry, the explainer video is currently unavailable.")
                            .font(.flightLogPrimary)
                    }
                    
                    Spacer()
                    
                }
                
                
                // Button "Continue" to next onboarding step
                Button(action: {
                    NotificationCenter.default.post(name: NSNotification.Name("StopVideoPlayer"), object: nil)
                    navigateToNextView = true // Navigation triggered by state change
                }) {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                    .font(.flightLogSecondary)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 700)
                .navigationDestination(isPresented: $navigateToNextView) {
                        Onboarding3View() // Navigation triggered by state change
                }
                
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Onboarding2View()
}
