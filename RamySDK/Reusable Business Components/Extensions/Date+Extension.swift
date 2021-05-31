//
//  Date+Extension.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 15/04/2021.
//

import Foundation

public extension Date {
  func format(with formatValue: DateFormat) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatValue.rawValue
    let dateString = dateFormatter.string(from: self)
    return dateString
  }
  
  static var now: Date {
    return .init()
  }
}
