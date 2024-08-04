//
//  CopyrightView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 30.06.2024.
//

import SwiftUI

struct CopyrightView: View {
    
    @State private var isDisclaimerPresented = false
    
    var body: some View {
        ZStack {
            
            VStack (alignment: .leading) {
                // Title
                Text("Copyright")
                    .font(.mainHeadline)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                
                JustifiedText(text: localizedTextOne())
                    .opacity(0.7)
                    .padding(.horizontal, -5)
                    .frame(height: 160)
                    .allowsHitTesting(false) // remove unnecessary scroll ability from JustifiedText
                
                Link("Website", destination: URL(string: "https://www.daec.de/")!)
                    .opacity(0.7)
                    .font(.system(size: 15, weight: .light))
                    .padding(.top, -10)
                    .padding(.bottom, 20)
                
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
                
                
                JustifiedText(text: localizedTextTwo())
                    .opacity(0.7)
                    .padding(.horizontal, -5)
                    .frame(height: 110)
                    .allowsHitTesting(false) // remove unnecessary scroll ability from JustifiedText
                
                Text("Read the disclaimer")
                    .font(.system(size: 12, weight: .light))
                    .underline()
                    .opacity(0.7)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        isDisclaimerPresented.toggle()
                    }
                    .sheet(isPresented: $isDisclaimerPresented) {
                        DisclaimerView()
                            .presentationDetents([.fraction(0.7)])
                    }
                
                Spacer()
                
            }
            .padding(.horizontal)
            
            
            // Close button top right
            CloseButtonView()
            
        }
        
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

#Preview {
    CopyrightView()
}
