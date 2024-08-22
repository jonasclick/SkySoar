//
//  StatCardFunctionTimeView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 20.08.2024.
//

import SwiftUI

struct StatCardFunctionTimeView: View {
    
    var pilotFunctionTime: PilotFunctionTime
    var value: Double
    
    var body: some View {
        
        // Stat Card
        VStack (alignment: .leading) {
            Image(systemName: pilotFunctionTime.sfSymbol())
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.6)
            Spacer()
            Text(TrainingStateHelper.noDotZero(value))
                .font(.statNumber)
            Text(pilotFunctionTime.labelEN())
                .font(.sectionHeadline)
                .opacity(0.6)
            
        }
        .padding()
        .frame(width: 130, height: 130)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.08), radius: 7, x: 3, y: 4)
    }
    
}

#Preview {
    StatCardFunctionTimeView(pilotFunctionTime: PilotFunctionTime.instructorAndPic, value: 12.2)
}
