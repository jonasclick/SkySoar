//
//  TextHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 04.08.2024.
//

import Foundation


struct TextHelper {
    
    static func limitChars(input: String, limit: Int) -> String {
        
        // Don't return charactes over the limit number
        if input.count > limit { return String(input.prefix(limit)) }
        
        // else, return the input
        return input
    }
    
}
