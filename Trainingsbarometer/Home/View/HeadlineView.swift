//
//  HeadlineView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 24.06.2024.
//

import SwiftUI

struct HeadlineView: View {
    
    @Binding var filterLogic: FilterLogic
    
    var body: some View {
        
        if let currentLanguage = Locale.current.language.languageCode?.identifier {
            
            // Display headline Texts for Localization EN
            if currentLanguage == "en" {
                
                switch filterLogic {
                case .total:
                    Text(try! AttributedString(markdown: "__All__ your flights"))
                        .font(.system(size: 27))
                case .lastSixMonths:
                    Text(try! AttributedString(markdown: "Your flights in the __last six months__"))
                        .font(.system(size: 27))
                case .thisYear:
                    Text(try! AttributedString(markdown: "Your flights __this year__"))
                        .font(.system(size: 27))
                case .lastYear:
                    Text(try! AttributedString(markdown: "Your flights __last year__"))
                        .font(.system(size: 27))
                }
                
            }
            
            
            // Display headline Texts Localization DE
            if currentLanguage == "de" {
                
                switch filterLogic {
                case .total:
                    Text(try! AttributedString(markdown: "__Alle__ deine Flüge"))
                        .font(.system(size: 27))
                case .lastSixMonths:
                    Text(try! AttributedString(markdown: "Deine Flüge der __letzten sechs Monate__"))
                        .font(.system(size: 22))
                case .thisYear:
                    Text(try! AttributedString(markdown: "Deine Flüge __in diesem Jahr__"))
                        .font(.system(size: 23))
                case .lastYear:
                    Text(try! AttributedString(markdown: "Deine Flüge __im letzten Jahr__"))
                        .font(.system(size: 23))
                }
                
            }
        }
    }
}
