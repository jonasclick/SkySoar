//
//  HeadlineView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 24.06.2024.
//

import SwiftUI

struct HeadlineView: View {
    
    @Binding var filterLogic: FilterLogic
    
    private var key: String {
        switch filterLogic {
        case.total: return "headline_total"
        case.lastSixMonths: return "headline_lastSixMonths"
        case.thisYear: return "headline_thisYear"
        case.lastYear: return "headline_lastYear"
        }
    }
    
    var body: some View {
        
        let markdown = NSLocalizedString(key, comment: "")
        
        Text(try! AttributedString(markdown: markdown))
        
    }
}
