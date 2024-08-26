//
//  NavigationButtonsView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 20.08.2024.
//

import SwiftUI

struct NavigationButtonsView: View {
    
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
