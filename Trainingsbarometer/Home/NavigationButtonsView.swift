//
//  NavigationButtonsView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 20.08.2024.
//

import SwiftUI

struct NavigationButtonsView: View {
    
    @AppStorage("onboarding") var needsOnboarding = true
    
    @Binding var isSettingsPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                
                // MARK: Settings
                Button(action: {
                    isSettingsPresented = true
                    HapticHelper.impact()
                }, label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 25))
                })
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // MARK: Reset Onboarding (for development purposes only)
//                Button(action: {
//                    needsOnboarding = true
//                }, label: {
//                    Image(systemName: "gobackward")
//                        .imageScale(.large)
//                        .padding(.trailing, 10)
//                })
//                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // MARK: Flight Logs List
                NavigationLink (destination: FlightLogsView()) {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 30))
                }
                .buttonStyle(PlainButtonStyle())
                .simultaneousGesture(TapGesture().onEnded { HapticHelper.impact() })
                
            }
            .padding(35)
        }
    }
}

#Preview {
    NavigationButtonsView(isSettingsPresented: .constant(false))
}
