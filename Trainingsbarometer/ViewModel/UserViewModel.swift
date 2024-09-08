//
//  UserViewModel.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 25.08.2024.
//

import Foundation
import SwiftUI
import RevenueCat

class UserViewModel: ObservableObject {
    
    @Published var isSubscriptionActive: Bool = false
    
    init() {
        
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            self.isSubscriptionActive = customerInfo?.entitlements["Supporter"]?.isActive == true
        }
        
    }
    
    public func refreshIsSubscriptionActive() {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            self.isSubscriptionActive = customerInfo?.entitlements["Supporter"]?.isActive == true
        }
    }
    
    public func checkAppIcon() {
        
        guard UIApplication.shared.alternateIconName != nil else { return }
        
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let customerInfo = customerInfo {
                if customerInfo.entitlements["Supporter"]?.isActive == true {
                    print("checkAppIcon() identified User as 'Supporter'")
                    return
                }
                else { UIApplication.shared.setAlternateIconName(nil) { (error) in
                    if let error = error {
                        print("checkAppIcon() failed to reset the app’s icon: \(error)")
                    }
                }
                }
            } else if let error = error {
                print("checkAppIcon() failed to fetch customer info: \(error)")
                return
            }
        }
    }
    
}
