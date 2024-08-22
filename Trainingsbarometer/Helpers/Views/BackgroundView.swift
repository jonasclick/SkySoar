//
//  BackgroundView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 23.06.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        
        Color.washedGray
        
        Rectangle()
            .foregroundStyle(Color.washedGray)
            .frame(width: 783, height: 347)
            .position(x: 200, y: 398)
            .rotationEffect(Angle(degrees: -36.57))
            .shadow(color: Color.black.opacity(0.03), radius: 10, x: -5, y: -5)
        
        Rectangle()
            .foregroundStyle(Color.washedGray)
            .frame(width: 783, height: 347)
            .position(x: 200, y: 720)
            .rotationEffect(Angle(degrees: -36.57))
            .shadow(color: Color.black.opacity(0.03), radius: 10, x: -5, y: -5)
    }
}

#Preview {
    BackgroundView()
}
