//
//  HeadlineView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 24.06.2024.
//

import SwiftUI

struct HeadlineView: View {
    
    @Binding var trainingState: Int
    
    let stateOneString = try! AttributedString(
        markdown: "Übung tut not -\nFliegen kann zum __Risiko__ werden.")
    
    let stateTwoString1 = try! AttributedString(
        markdown: "Mehr Übung könnte nicht")
    
    let stateTwoString2 = try! AttributedString(
        markdown: "schaden __– unerwartete Ereignisse__ können")
    
    let stateTwoString3 = try! AttributedString(
        markdown: "gefährlich werden.")
    
    let stateThreeString = try! AttributedString(
        markdown: "Dein Übungsstand \nist gut __– trotzdem Vorsicht.__")
    
    
    var body: some View {
        
        // Headline Text
        if trainingState == 1 {
            Text(stateOneString)
                .font(.system(size: 34))
                .padding(.bottom, 40)
        }
        else if trainingState == 2 {
            Text("\(stateTwoString1)\n\(stateTwoString2)\n\(stateTwoString3)")
                .font(.system(size: 29))
                .padding(.bottom, 40)
        }
        else if trainingState == 3 {
            Text(stateThreeString)
                .font(.system(size: 34))
                .padding(.bottom, 40)
        }
        
    }
}

//#Preview {
//    HeadlineView(trainingState: 1)
//}
