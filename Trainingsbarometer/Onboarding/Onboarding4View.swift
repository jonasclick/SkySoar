//
//  Onboarding4View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 07.07.2024.
//

import SwiftUI

struct Onboarding4View: View {
    
    @AppStorage("onboarding") var needsOnboarding = true
    @Environment(\.modelContext) private var context
    
    @State private var showSampleDataAlert = false
    
    var body: some View {
        NavigationStack {
            
            // Title "Onboarding"
            HStack {
                VStack (alignment: .leading) {
                    Text("Onboarding")
                        .font(.mainHeadline)
                    Text("Try sample flights to explore the app without having to enter your own details yet.")
                        .multilineTextAlignment(.leading)
                        .opacity(0.8)
                        .padding(.top, -10)
                }
                .frame(idealWidth: .infinity)
                .padding()
                Spacer()
            }
            
            Spacer()
            
            
            // MARK: WITH sample flight data
            Button(action: {
                HapticHelper.warning()
                showSampleDataAlert = true
            }, label: {
                VStack {
                    Image(systemName: "arrow.right.circle.fill")
                        .padding(.bottom, 4)
                    Text("Explore the app")
                        .bold()
                        .padding(.bottom, 1)
                    Text("with sample flights")
                        .font(.footnote)
                }
            })
            .buttonStyle(PlainButtonStyle())
            .alert("Sample Flights Added", isPresented: $showSampleDataAlert, actions: {
                Button {
                    HapticHelper.success()
                    SampleDataHelper.addSampleData(context: context)
                    needsOnboarding = false
                } label: {
                    Text("I understand: It's not my practice state")
                        .foregroundStyle(Color.red)
                        .bold()
                }}, message: { Text("\nTen sample flights have been added. Therefore: Do not mistake the practice state shown in the app with your own practice state!") })
            
            
            Spacer()
            
            
            
            // MARK: WITHOUT sample flight data
            Button(action: {
                needsOnboarding = false
            }, label: {
                VStack {
                    Image(systemName: "arrow.right.circle.fill")
                        .padding(.bottom, 4)
                    Text("Start using the app")
                        .bold()
                        .padding(.bottom, 1)
                    Text("without sample flights")
                        .font(.footnote)
                }
            })
            .buttonStyle(PlainButtonStyle())
            
            
            Spacer()
            
            
            Text("You can always add and remove \nsamlple flights later in settings.")
                .font(.footnote)
                .opacity(0.7)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            
            Spacer()
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Onboarding4View()
}
