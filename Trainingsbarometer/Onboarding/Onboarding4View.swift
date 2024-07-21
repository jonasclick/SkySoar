//
//  Onboarding4View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 06.07.2024.
//

import SwiftUI

struct Onboarding4View: View {
    var body: some View {
        VStack (alignment: .leading) {
            
            // Title
            Text("Copyright")
                .font(.mainHeadline)
                .padding(.top, 30)
                .padding(.bottom, 10)
            
            // Disclaimer Text
            JustifiedText(text: localizedTextOne())
                .opacity(0.7)
                .padding(.horizontal, -5)
                .frame(height: 160)
                .allowsHitTesting(false) // remove unnecessary scroll ability from JustifiedText
            
            // Link to website
            Link("Website", destination: URL(string: "https://www.daec.de/")!)
                .opacity(0.7)
                .font(.system(size: 15, weight: .light))
                .padding(.top, -10)
                .padding(.bottom, 20)
            
            // Link to ressources
            HStack {
                Text("The pilot practice barometer can be found")
                    .opacity(0.7)
                    .font(.system(size: 15, weight: .light))
                Link("here", destination: URL(string: "https://www.daec.de/sportarten/segelflug/downloads-termine/#c505")!)
                    .opacity(0.7)
                    .font(.system(size: 15, weight: .light))
                    .padding(.leading, -3)
            }
            HStack {
                Text("and the poster can be downloaded")
                    .opacity(0.7)
                    .font(.system(size: 15, weight: .light))
                Link("here", destination: URL(string: "https://www.daec.de/media/files/2023/Sportarten/Segelflug/Downloads/DAeC-Trainingbarometer_A3-Plakat_RZ_Druck_a.pdf")!)
                    .opacity(0.7)
                    .font(.system(size: 15, weight: .light))
                    .padding(.leading, -3)
                Text(".")
                    .opacity(0.7)
                    .font(.system(size: 15, weight: .light))
                    .padding(.leading, -8)
            }
            
            // Info paragraph about app using same logic as poster of DAEC
            JustifiedText(text: localizedTextTwo())
                .opacity(0.7)
                .padding(.horizontal, -5)
                .frame(height: 110)
                .allowsHitTesting(false) // remove unnecessary scroll ability from JustifiedText
            
            
            
            // Button "Continue" to next onboarding step
            VStack (alignment: .center) {
                NavigationLink (destination: {
                    Onboarding5View()
                }, label: {
                    HStack {
                        Text("Continue")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                    .font(.flightLogSecondary)
                })
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
    }
    
    private func localizedTextOne() -> String {
        return (Locale.current.language.languageCode?.identifier ?? "") == "de" ?
                "Das Konzept des Trainingsbarometers und die Empfehlungstexte in dieser App wurden erstellt gemäss dem Trainingsbarometerplakat des\n\nDeutscher Aero Club e.V.\nHermann-Blenk-Str. 28\n38108 Braunschweig\nDeutschland" :
                "The concept of the pilot practice barometer and the recommendation texts found in this application are made by\n\nDeutscher Aero Club e.V.\nHermann-Blenk-Str. 28\n38108 Braunschweig\nGermany"
    }
    
    private func localizedTextTwo() -> String {
        return (Locale.current.language.languageCode?.identifier ?? "") == "de" ?
                "Diese App nutzt die Logik, die sich aus dem Plakat des Deutschen Aero Clubs ergibt and zeigt denselben Trainingsstand an, vorausgesetzt die*der Nutzer*in hat ihre*seine Flüge in dieser App korrekt erfasst." :
                "This app uses the same logic as is used in the info poster by Deutscher Aero Club e.V. and therefore shows the same practice state, provided that the user inputs corect data."
    }
}
