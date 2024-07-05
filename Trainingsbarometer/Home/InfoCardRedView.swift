//
//  InfoCardRedView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 24.06.2024.
//

import SwiftUI

struct InfoCardRedView: View {
    
    @State private var isCopyrightPresented = false
    
    var body: some View {
        
        ZStack {
            
            VStack (alignment: .leading) {
                // Info Card Title
                HStack {
                    Image(systemName: "info.circle")
                        .bold()
                    Text("For inexperienced pilots")
                        .font(.infoBoxHeadline)
                }
                .padding(.bottom, 10)
                
                
                // Info Card Text
                VStack (alignment: .leading, spacing: -5) {
                    HStack {
                        Text("""
                         Perform the first take-offs after a long break only with familiar aircraft models and in non-critical weather conditions.
                         
                         """)
                    }
                    HStack {
                        Text("""
                        If the last take-off was more than three months ago, training with a flight instructor is the best way to achieve a good practice level.
                        """)
                    }
                    .padding(.top, 10)
                }
                .font(.infoBoxContent)
            }
            
            VStack {
                Spacer()
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
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 180, alignment: .leading)
        .background(Color.barometerRed)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.18), radius: 7, x: 3, y: 4)
    }
}

#Preview {
    InfoCardRedView()
}
