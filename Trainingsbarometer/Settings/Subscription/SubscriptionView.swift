//
//  SubscriptionView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 23.08.2024.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

struct SubscriptionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var shouldDisplayPaywall: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                // Display content depending on if user is subscribed or not
                if userViewModel.isSubscriptionActive {
                    SubscriptionActiveView()
                }
                else {
                    SubscriptionInactiveView(shouldDisplayPaywall: $shouldDisplayPaywall)
                }
                
                
            }
            .padding(.horizontal, 50)
            
            CloseButtonView()
        }
        
        // MARK: RevenueCat Paywall for user to subscribe
        .sheet(isPresented: $shouldDisplayPaywall, onDismiss: userViewModel.refreshIsSubscriptionActive, content: {
            PaywallView()
        })
        .onAppear {
            userViewModel.refreshIsSubscriptionActive()
        }
    }
}

#Preview {
    SubscriptionView()
}
