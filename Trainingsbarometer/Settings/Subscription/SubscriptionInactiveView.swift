//
//  SubscriptionInactiveView.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 25.08.2024.
//

import SwiftUI

struct SubscriptionInactiveView: View {
    
    @Binding var shouldDisplayPaywall: Bool
    
    var body: some View {
        Spacer()
        
        // Thank you message
        Text("Consider supporting \(Image(systemName: "heart.fill")) the continuous development of SkySoar.")
            .multilineTextAlignment(.center)
        
        Spacer()
        
        // Showcase Supporter App Icon
        Image(.supporterAppIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.bottom, 30)
        
        Text("As a supporter you will get access to this Supporter App Icon.")
            .multilineTextAlignment(.center)
            .font(.subheadline)
        
        Spacer()
        
        // Button for user to change app icon
        Button(action: {
            shouldDisplayPaywall = true
        }, label: {
            Text("See support options")
        })
        .buttonStyle(BorderedProminentButtonStyle())
        
        Spacer()
    }
}

#Preview {
    SubscriptionInactiveView(shouldDisplayPaywall: .constant(false))
}
