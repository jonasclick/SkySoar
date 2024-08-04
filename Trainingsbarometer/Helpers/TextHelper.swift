//
//  TextHelper.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 04.08.2024.
//

import Foundation


struct TextHelper {
    
    static func limitChars(input: String, limit: Int) -> String {
        // If the input is above the limit, take the first "limit" number of characters
        if input.count > limit {
            return String(input.prefix(limit))
        }
        return input
    }
    
}
