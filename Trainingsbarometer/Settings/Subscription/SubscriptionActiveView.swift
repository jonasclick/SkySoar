//
//  SubscriptionActiveView.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 25.08.2024.
//

import SwiftUI

struct SubscriptionActiveView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var isDefaultAppIcon = UIApplication.shared.alternateIconName == nil ? false : true
    
    var body: some View {
        Spacer()
        
        // Thank you message
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
        
        // Button for user to change app icon
        Button(action: {
            setAppIcon(isDefault: UIApplication.shared.alternateIconName == nil ? false : true)
            updateIsDefaultAppIcon()
        }, label: {
            Text(UIApplication.shared.alternateIconName == nil ? "Set Supporter App Icon" : "Set default app icon")
        })
        .buttonStyle(BorderedProminentButtonStyle())
        .disabled(userViewModel.isSubscriptionActive == false)
        
        Spacer()
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
    
    private func updateIsDefaultAppIcon() {
        isDefaultAppIcon = UIApplication.shared.alternateIconName == nil ? false : true
    }
    
}

#Preview {
    SubscriptionActiveView()
}
