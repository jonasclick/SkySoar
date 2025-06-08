//
//  DisclaimerView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 26.06.2024.
//

import SwiftUI

struct DisclaimerView: View {
    
    @State private var isWebsitePresented = false
    
    var body: some View {
        
        ZStack {
            VStack (alignment: .leading) {
                // Title
                Text("Disclaimer")
                    .font(.mainHeadline)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                
                // Text EN
                JustifyTextHelper(text: localizedLabel)
                    .opacity(0.7)
                    .padding(.horizontal, -5)
                    .frame(height: 330)
                    .allowsHitTesting(false) // remove unnecessary scroll ability from JustifiedText
                
                // Link to website
                Text("Developers Website")
                    .font(.system(size: 12, weight: .light))
                    .underline()
                    .opacity(0.7)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        isWebsitePresented.toggle()
                    }
                
                Spacer()
                
            }
            .padding(.horizontal)
            
            // Close Button top right
            CloseButtonView()
            
        }
        .sheet(isPresented: $isWebsitePresented, content: {
            WebsiteView(title: "Developers Website", url: "https://github.com/jonasclick/Trainingsbarometer")
        })
    }
    
    var localizedLabel: String {
        NSLocalizedString("disclaimer_text", comment: "Disclaimer text")
    }
    
}

#Preview {
    DisclaimerView()
}
