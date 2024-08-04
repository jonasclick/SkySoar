//
//  InfoCardGreenView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 24.06.2024.
//

import SwiftUI

struct InfoCardGreenView: View {
    
    @State private var isCopyrightPresented = false
    
    var body: some View {
        
        ZStack {
            VStack (alignment: .leading) {
                // Info Card Title
                HStack {
                    Image(systemName: "info.circle")
                        .bold()
                    Text("Experienced pilots make the following mistakes")
                        .font(.infoBoxHeadline)
                }
                .padding(.bottom, 15)
                
                VStack (alignment: .leading) {
                    // Info Card Text
                    HStack {
                        Image(systemName: "chevron.forward")
                            .scaleEffect(0.7)
                        Text("Glider improperly equipped")
                    }
                    .padding(.bottom, 2)
                    HStack {
                        Image(systemName: "chevron.forward")
                            .scaleEffect(0.7)
                        Text("Not performing cockpit check correctly")
                    }
                    .padding(.bottom, 2)
                    HStack {
                        Image(systemName: "chevron.forward")
                            .scaleEffect(0.7)
                        Text("Misbehavior during aborted takeoffs")
                    }
                    .padding(.bottom, 2)
                    HStack {
                        Image(systemName: "chevron.forward")
                            .scaleEffect(0.7)
                        Text("Poorly flown landing pattern (e.g. during outlanding)")
                    }
                }
                .padding(.leading, 5)
//                .padding(.bottom, 16)
                .font(.infoBoxContent)
                
            }
            
            VStack {
                (Locale.current.language.languageCode?.identifier ?? "") == "de" ? Spacer() : nil
                HStack {
                    Spacer()
                    Image(systemName: "c.circle")
                        .opacity(0.6)
                        .scaleEffect(0.8)
                        .padding(-5)
                        .onTapGesture {
                            isCopyrightPresented = true
                        }
                        .sheet(isPresented: $isCopyrightPresented) {
                            CopyrightView()
                                .presentationDetents([.fraction(0.7)])
                        }
                }
                (Locale.current.language.languageCode?.identifier ?? "") == "de" ? nil : Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 165, alignment: .leading)
        .background(Color.barometerGreen)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.08), radius: 7, x: 3, y: 4)
    }
}

#Preview {
    InfoCardGreenView()
}
