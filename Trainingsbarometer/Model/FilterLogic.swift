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
  
  func dateRange() -> (start: Date, end: Date) {
    let calendar = Calendar.current
    let today = Date()
    
    switch self {
    case .total:
      return (start: .distantPast, end: today)
    case .lastSixMonths:
      let start = calendar.date(byAdding: .month, value: -6, to: today)!
      return (start: start, end: today)
    case .thisYear:
      let start = calendar.date(from: calendar.dateComponents([.year], from: today))!
      return (start: start, end: today)
    case .lastYear:
      let year = calendar.component(.year, from: today) - 1
      let start = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
      let end = calendar.date(from: DateComponents(year: year, month: 12, day: 31))!
      return (start: start, end: end)
    }
  }
}
