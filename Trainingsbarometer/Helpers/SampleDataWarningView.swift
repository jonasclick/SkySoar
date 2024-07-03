//
//  SampleDataWarningView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 03.07.2024.
//

import SwiftUI
import SwiftData

struct SampleDataWarningView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var flightLogs: [FlightLog]
    
    private var isSampleData: Bool {SampleDataHelper.initializeIsSampleData(from: flightLogs)}
    
    var body: some View {
        
        // Show warning if app is using sample data
        if isSampleData {
            VStack {
                HStack (spacing: 4) {
                    Image(systemName: "info.circle")
                    Text("App is using sample flights")
                }
                .font(.system(size: 10, weight: .bold))
                .padding(8)
                .background(.barometerRed)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.top, 55)
                
                
                Spacer()
                
            }
            
        }
    }
}

#Preview {
    SampleDataWarningView()
}
