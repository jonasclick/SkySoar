//
//  HeadlineView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 24.06.2024.
//

import SwiftUI

struct HeadlineView: View {
    
    @Binding var trainingState: Int
    
    var body: some View {
        
        if let currentLanguage = Locale.current.language.languageCode?.identifier {
            
            // Display headline Texts EN
            if currentLanguage == "en" {
                let stateOneString = try! AttributedString(
                    markdown: "Practice is necessary - flying can become a __risk__.")
                
                let stateTwoString1 = try! AttributedString(
                    markdown: "More practice couldn't hurt – __unexpected events__ can become dangerous.")
                
                let stateThreeString = try! AttributedString(
                    markdown: "Your practice state is good – but still __be cautious.__")
                
                
                if trainingState == 1 {
                    Text(stateOneString)
                        .font(.system(size: 32))
                        .padding(.bottom, 40)
                }
                else if trainingState == 2 {
                    Text("\(stateTwoString1)")
                        .font(.system(size: 27))
                        .padding(.bottom, 40)
                }
                else if trainingState == 3 {
                    Text(stateThreeString)
                        .font(.system(size: 34))
                        .padding(.bottom, 40)
                }
                
            }
            
            
            // Display headline Texts DE
            if currentLanguage == "de" {
                let stateOneString = try! AttributedString(
                    markdown: "Übung ist notwendig – Fliegen kann zum __Risiko__ werden.")
                
                let stateTwoString1 = try! AttributedString(
                    markdown: "Mehr Übung könnte nicht")
                
                let stateTwoString2 = try! AttributedString(
                    markdown: "schaden __– unerwartete Ereignisse__ können")
                
                let stateTwoString3 = try! AttributedString(
                    markdown: "gefährlich werden.")
                
                let stateThreeString = try! AttributedString(
                    markdown: "Der Übungszustand ist gut – __trotzdem Vorsicht.__")
                
                
                if trainingState == 1 {
                    Text(stateOneString)
                        .font(.system(size: 34))
                        .padding(.bottom, 40)
                }
                else if trainingState == 2 {
                    Text("\(stateTwoString1)\n\(stateTwoString2)\n\(stateTwoString3)")
                        .font(.system(size: 31))
                        .padding(.bottom, 40)
                }
                else if trainingState == 3 {
                    Text(stateThreeString)
                        .font(.system(size: 32))
                        .padding(.bottom, 40)
                }
                
                
            }
        }
    }
}
