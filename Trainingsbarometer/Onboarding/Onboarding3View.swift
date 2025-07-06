//
//  Onboarding3View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 05.07.2024.
//

import SwiftUI

struct Onboarding3View: View {
    
    @State private var isWebsitePresented = false
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                
                // Title
                Text("Onboarding")
                    .font(.mainHeadline)
                    .padding(.top, 30)
                
                Text("Disclaimer")
                    .padding(.bottom, 30)
                
                // Text EN
                JustifyTextHelper(text: localizedLabel)
                    .padding(.horizontal, -5)
                    .frame(height: 330)
                    .allowsHitTesting(false) // remove unnecessary scroll ability from JustifiedText
                
                // Link to developers website
                Text("Developers Website")
                    .font(.system(size: 12, weight: .light))
                    .underline()
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        isWebsitePresented.toggle()
                    }
            }
            .padding(.horizontal)
            .sheet(isPresented: $isWebsitePresented, content: {
                WebsiteView(title: "Developers Website", url: "https://github.com/jonasclick/Trainingsbarometer")
            })
            
            // Button "Continue" to next onboarding step
            NavigationLink(destination: Onboarding4View()) {
                Text("I understand")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 50)
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 30)
            }
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var localizedLabel: String {
        NSLocalizedString("disclaimer_text", comment: "Disclaimer text")
    }
    
}

#Preview {
    Onboarding3View()
}
