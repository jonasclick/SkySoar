//
//  HomeView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            // Headline Section
            Text("Übungsstand")
            Text("Dein Übungsstand ist gut – trotzdem Vorsicht.")
            Spacer()
            
            // InfoCardView
            VStack {
                // Title
                HStack {
                    Image(systemName: "info.circle")
                    Text("Geübte Piloten machen folgende Fehler")
                }
                
                // Text List
                HStack {
                    Image(systemName: "chevron.forward")
                    Text("Segelflugzeug fehlerhaft ausgerüstet")
                }
                HStack {
                    Image(systemName: "chevron.forward")
                    Text("mangelhafter Cockpitcheck")
                }
                HStack {
                    Image(systemName: "chevron.forward")
                    Text("Fehlverhalten bei Startunterbrechungen")
                }
                HStack {
                    Image(systemName: "chevron.forward")
                    Text("Fehler bei der Landeeinteilung (vor allem bei Aussenlandungen)")
                }
            }
            .padding()
            .background {
                Color.blue
                    .clipShape(Rectangle())
            }
            .padding()
            
            Spacer()
            
            // Stats Section
            Text("In den letzten sechs Monaten")
            // Stat Hours
            // Stat Starts
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
