//
//  JustifyTextHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 26.06.2024.
//

import Foundation
import SwiftUI

// Helper to display multiline text with justified allignment.
struct JustifyTextHelper: UIViewRepresentable {
    
    var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15, weight: .light, width: .standard)
        textView.textAlignment = .justified
        
        // Disable edit and select, as this view is only used for displaying text.
        textView.isEditable = false
        textView.isSelectable = false
        
        textView.backgroundColor = .clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
