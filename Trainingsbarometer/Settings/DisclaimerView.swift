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
                
                // Text
                JustifiedText(text: "This application is designed to assist your flying hobby and enhance safety by presenting user-provided information in a clear and accessible manner.\n\nHowever, reliance solely on the information provided by this application is not recom-mended. It is crucial to verify all information independently, as the application may contain functional errors or inaccuracies, and user-entered data may be incorrect.\n\nThe developers and the application itself disclaim any liability for actions or decisions, flying-related or not, made based on the information provided by the application.")
                    .opacity(0.7)
                    .padding(.horizontal, -5)
                    .frame(height: 300)
                
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
}

#Preview {
    DisclaimerView()
}
