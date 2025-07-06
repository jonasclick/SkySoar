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
    
    var sfSymbolName: String {
        switch self {
        case .pic: return "person"
        case .dual: return "person.2"
        case .instructorAndPic: return "graduationcap"
        }
    }
    
    private var labelKey: String {
        switch self {
        case .pic: return "pilotFunctionTime_pic"
        case .dual: return "pilotFunctionTime_dual"
        case .instructorAndPic: return "pilotFunctionTime_instructorAndPic"
        }
    }
    
    var localizedLabel: String {
        NSLocalizedString(labelKey, comment: "Label for pilot function time")
    }
    
}
