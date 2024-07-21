//
//  Onboarding5View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 07.07.2024.
//

import SwiftUI

struct Onboarding5View: View {
    
    @AppStorage("onboarding") var needsOnboarding = true
    @Environment(\.modelContext) private var context
    
    @State private var showSampleDataAlert = false
    
    var body: some View {
        NavigationStack {
            
            // Title "Onboarding"
            HStack {
                VStack (alignment: .leading) {
                    Text("Complete Onboarding")
                        .font(.mainHeadline)
                    Text("Try sample flights to explore the app without spending time entering your own details yet.")
                        .font(.infoBoxContent)
                        .opacity(0.8)
                        .frame(width: 300, alignment: .leading)
                        .padding(.top, -10)
                }
                .frame(idealWidth: .infinity)
                .padding()
                Spacer()
            }
            
            Spacer()
            
            
            // Dismiss onboarding WITH using sample flight data
            Button(action: {
                showSampleDataAlert = true
            }, label: {
                VStack {
                    Text("Explore the app")
                        .font(.infoBoxHeadline)
                        .padding(.bottom, 1)
                    Text("with sample flights")
                        .font(.infoBoxContent)
                        .padding(.bottom, 10)
                    Image(systemName: "arrow.right.circle.fill")
                }
            })
            .buttonStyle(PlainButtonStyle())
            .alert("Sample Flights Added", isPresented: $showSampleDataAlert, actions: {
                Button {
                    SampleDataHelper.addSampleData(context: context)
                    needsOnboarding = false
                } label: {
                    Text("I understand: It's not my training state")
                        .foregroundStyle(Color.red)
                        .bold()
                }}, message: {
                    Text("\nTen sample flights have been added. Therefore: Do not mistake the training state shown in the app with your own training state!")
                })
            
            
            Spacer()
            
            
            
            // Dismiss onboarding WITHOUT sample flight data
            Button(action: {
                needsOnboarding = false
            }, label: {
                VStack {
                    Text("Start using the app")
                        .font(.infoBoxHeadline)
                        .padding(.bottom, 1)
                    Text("without sample flights")
                        .font(.infoBoxContent)
                        .padding(.bottom, 10)
                    Image(systemName: "arrow.right.circle.fill")
                }
            })
            .buttonStyle(PlainButtonStyle())
            
            
            Spacer()
            
            
            Text("You can always change your mind later in Settings.")
                .font(.infoBoxContent)
                .opacity(0.7)
                .multilineTextAlignment(.center)
            
            
            Spacer()
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
