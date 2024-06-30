//
//  CloseButtonView.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 30.06.2024.
//

import SwiftUI

struct CloseButtonView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        // Place a close button at the top right of a view
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }, label: {
                    Image("close button")
                        .padding(10)
                })
            }
            Spacer()
        }
        
        
    }
}

#Preview {
    CloseButtonView()
}
