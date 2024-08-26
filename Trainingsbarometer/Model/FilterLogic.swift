//
//  FilterLogic.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 20.08.2024.
//

import Foundation

enum FilterLogic: Int {
    case total
    case lastSixMonths
    case thisYear
    case lastYear
    
    func returnInt() -> Int {
        switch self {
        case .total:
            return 0
        case .lastSixMonths:
            return 1
        case .thisYear:
            return 2
        case .lastYear:
            return 3
        }
    }
    
    func startDate() -> Int {
        switch self {
        case .total:
            return 1200
        case .lastSixMonths:
            return 6
        case .thisYear:
            return 12
        case .lastYear:
            return 24
        }
    }
    
    func endDate() -> Int {
        switch self {
        case .total:
            return 0
        case .lastSixMonths:
            return 0
        case .thisYear:
            return 0
        case .lastYear:
            return 12
        }
    }
    
    
}
