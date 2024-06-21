//
//  HomeView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.06.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.washedGreen
                
                Rectangle()
                    .foregroundStyle(Color.washedGreen)
                    .frame(width: 783, height: 347)
                    .position(x: 200, y: 398)
                    .rotationEffect(Angle(degrees: -36.57))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: -5, y: -5)
                
                
                Rectangle()
                    .foregroundStyle(Color.washedGreen)
                    .frame(width: 783, height: 347)
                    .position(x: 200, y: 720)
                    .rotationEffect(Angle(degrees: -36.57))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: -5, y: -5)
                
                VStack (alignment: .leading) {
                    
                    // Headline Section
                    Text("Übungsstand")
                        .font(.sectionHeadline)
                        .padding(.bottom, 13)
                    Text("Dein Übungsstand \nist gut – trotzdem Vorsicht.")
                        .font(.mainHeadline)
                        .padding(.bottom, 40)
                    
                    // InfoCardView
                    VStack (alignment: .leading) {
                        // Title
                        HStack {
                            Image(systemName: "info.circle")
                            Text("Geübte Piloten machen folgende Fehler")
                                .font(.infoBoxHeadline)
                        }
                        .padding(.bottom, 15)
                        
                        VStack (alignment: .leading) {
                            // Text List
                            HStack {
                                Image(systemName: "chevron.forward")
                                    .scaleEffect(0.7)
                                Text("Segelflugzeug fehlerhaft ausgerüstet")
                            }
                            .padding(.bottom, 2)
                            HStack {
                                Image(systemName: "chevron.forward")
                                    .scaleEffect(0.7)
                                Text("mangelhafter Cockpitcheck")
                            }
                            .padding(.bottom, 2)
                            HStack {
                                Image(systemName: "chevron.forward")
                                    .scaleEffect(0.7)
                                Text("Fehlverhalten bei Startunterbrechungen")
                            }
                            .padding(.bottom, 2)
                            HStack {
                                Image(systemName: "chevron.forward")
                                    .scaleEffect(0.7)
                                Text("Fehler bei der Landeeinteilung (vor allem bei Aussenlandungen)")
                            }
                        }
                        .padding(.leading, 19)
                        .font(.infoBoxContent)
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.barometerGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.2), radius: 7, x: 3, y: 4)
                    .padding(.bottom, 40)
                    
                    // Stats Section
                    Text("In den letzten sechs Monaten")
                        .font(.sectionHeadline)
                        .padding(.bottom, 0.5)
                    Text("03.12.2023 – 03.06.2023")
                        .font(.sectionHeadline)
                        .opacity(0.5)
                        .padding(.bottom, 15)
                    
                    HStack {
                        // Stat Stunden
                        StatCardView(image: "clock", number: 23, label: "Stunden")
                            .padding(.trailing, 50)
                        // Stat Starts
                        StatCardView(image: "airplane.departure", number: 11, label: "Starts")
                    }
                }
                .padding(.horizontal, 20)
                
                // Navigation Buttons
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        NavigationLink (destination: FlightLogsView()) {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 30))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(35)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    HomeView()
}
