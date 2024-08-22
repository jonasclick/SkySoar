//
//  GreetingView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 21.08.2024.
//

import SwiftUI

struct GreetingView: View {
    
    @AppStorage("Username") var userName: String = ""
    
    var body: some View {
        Text(getGreeting())
            .font(.subheadline)
            .fontWeight(.light)
            .padding(.top, 5)
            .padding(.bottom, 2)
    }
    
    private func getGreeting() -> LocalizedStringKey {
        let currentHour = Calendar.current.component(.hour, from: Date())
        if currentHour < 12 {
            return "Good morning\(userName)"
        } else if currentHour < 18 {
            return "Good afternoon\(userName)"
        } else {
            return "Good evening\(userName)"
        }
    }
}

#Preview {
    GreetingView(userName: ", Tom")
}
