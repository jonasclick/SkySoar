//
//  ExplainerVideoView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 30.06.2024.
//

import SwiftUI

struct ExplainerVideoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            VStack {
                
                // Title Card
                ZStack {
                    // Title Text
                    Text("Why Pilot Practice Barometer?")
                        .font(.flightLogPrimary)
                    // Close Button
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Done")
                                .bold()
                                .padding()
                        })
                    }
                }
                
                
                Spacer()
                
                
                if let localVideoURL = Bundle.main.url(forResource: "Why TBARO", withExtension: "mov") {
                    VideoPlayerView(videoURL: localVideoURL)
                        .aspectRatio(9/16, contentMode: .fill)
                        .padding(.top, -5)
                    
                } else {
                    Text("We're sorry, the explainer video is currently unavailable.")
                        .font(.flightLogPrimary)
                }
                
            }
    }
}

#Preview {
    ExplainerVideoView()
}
