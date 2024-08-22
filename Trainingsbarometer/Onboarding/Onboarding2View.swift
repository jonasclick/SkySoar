//
//  Onboarding2View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 05.07.2024.
//

import SwiftUI

struct Onboarding2View: View {
    
    @AppStorage("Username") var userName: String = ""
    
    @State private var userNameEntered: String = ""
    @State private var navigateToNextView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center) {
                
                // Title "Onboarding"
                HStack {
                    VStack (alignment: .leading) {
                        Text("Onboarding")
                            .font(.mainHeadline)
                    }
                    .frame(idealWidth: .infinity)
                    
                    Spacer()
                }
                
                Spacer()
                Spacer()
                
                // Set User Name
                Text("How would you like to be called?")
                    .padding(.bottom)
                
                TextField("Enter your name here", text: $userNameEntered)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .background(.washedGray)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text("You can change your user name later in settings.")
                    .font(.footnote)
                    .opacity(0.6)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                
                
                Spacer()
                Spacer()
                
                Image(systemName: "shield.lefthalf.filled.badge.checkmark")
                    .imageScale(.large)
                    .font(.title2)
                    .opacity(0.8)
                
                Text("Your name is used to greet you on the home screen. \nYour name will be stored on your device only and can't be accessed by anyone else.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .opacity(0.8)
                 
                Spacer()
                
                Spacer()
                
                
                // Button "Continue" to next onboarding step
                Button(action: {
                    userName = userNameEntered.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "" : String(", " + userNameEntered)
                    navigateToNextView = true // Navigation triggered by state change
                }) {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                // Navigation triggered by state change
                .navigationDestination(isPresented: $navigateToNextView) { Onboarding3View() }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Onboarding2View()
}
