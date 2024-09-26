//
//  PilotFunctionTime.swift
//  SkySoar
//
//  Created by Jonas Vetsch on 25.09.2024.
//

import Foundation


enum PilotFunctionTime: Int, Codable  {
    case pic = 0
    case dual = 1
    case instructorAndPic = 2
    
    func sfSymbol() -> String {
        switch self {
        case .pic:
            return "person"
        case .dual:
            return "person.2"
        case .instructorAndPic:
            return "graduationcap"
        }
    }
    
    func labelEN() -> String {
        switch self {
        case .pic:
            return "Hours PIC"
        case .dual:
            return "Hours Dual"
        case .instructorAndPic:
            return "Hours Instruct."
        }
    }
}
