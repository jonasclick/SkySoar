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
    
    @State private var isSupporter = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Spacer()
                
                
                Text("Thank you \(Image(systemName: "heart.fill")) for supporting the continuous development of SkySoar.")
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // Showcase Supporter App Icon
                Image(.supporterAppIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.bottom, 30)
                
                
                Text("You have now access to this Supporter App Icon, as a way of saying thank you for your support.")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                
                Spacer()
                
                // Let user change app icon
                Button(action: {
                    setAppIcon(isDefault: UIApplication.shared.alternateIconName == nil ? false : true)
                }, label: {
                    Text(UIApplication.shared.alternateIconName == nil ? "Set Supporter App Icon" : "Set default app icon")
                })
                .buttonStyle(BorderedProminentButtonStyle())
                
                Spacer()
                
                
            }
            .padding(.horizontal, 50)
            
            CloseButtonView()
        }
        .presentPaywallIfNeeded(
            requiredEntitlementIdentifier: "Supporter",
            purchaseCompleted: { customerInfo in
                print("Purchase completed: \(customerInfo.entitlements)") },
            restoreCompleted: { customerInfo in
                // Paywall will be dismissed automatically if "Supporter" is now active.
                print("Purchases restored: \(customerInfo.entitlements)") })
    }
    
    private func setAppIcon(isDefault: Bool) {
        
        let iconName: String? = (isDefault ? nil : "AppIconSupporter")
        
        // Avoid setting the name if the app already uses that icon.
        guard UIApplication.shared.alternateIconName != iconName else { return }
        
        UIApplication.shared.setAlternateIconName(iconName) { (error) in
            if let error = error {
                print("Failed request to update the app’s icon: \(error)")
            }
        }
    }
}

#Preview {
    SubscriptionView()
}
