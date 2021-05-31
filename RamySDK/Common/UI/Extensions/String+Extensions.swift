//
//  String+Extensions.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public extension String {
  static let empty = ""
  
  func toURL() -> URL? {
    URL(string: self)
  }
  
  var asError: Error {
    return NSError(domain: self, code: -1, userInfo: [NSLocalizedDescriptionKey: self])
  }
  
  func suffixCurrency() -> String {
    return "\(self) \(UserSettingsService.shared.currency.value ?? "")"
  }
  
  func prefixCurrency() -> String {
    return "\(UserSettingsService.shared.currency.value ?? "") \(self)"
  }
  
  /// The method loops over the currently supported formats and picks the suitable one
  /// Then returns a String with the format that the UI requires
  /// - Parameter requiredFormat: the format that the caller needs
  /// - Returns: Localized Formatted Date String
  func formattedDate(to requiredFormat: DateFormat) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let suitableFormat = DateFormat
      .allCases
      .first { (possibleFormat: DateFormat) -> Bool in
      dateFormatter.dateFormat = possibleFormat.rawValue
      return dateFormatter.date(from: self) != nil
      }?.rawValue ?? .empty
    
    dateFormatter.dateFormat = suitableFormat
    guard let date = dateFormatter.date(from: self) else { return self }
    dateFormatter.calendar = .current
    dateFormatter.locale = .current
    dateFormatter.timeZone = .current
    dateFormatter.dateFormat = requiredFormat.rawValue
    return dateFormatter.string(from: date)
  }
  
  /// The method loops over the currently supported formats and picks the suitable one
  /// Then returns a String with the format that the UI requires
  /// - Parameter requiredFormat: the format that the caller needs
  /// - Returns: Localized Formatted Date
  func formattedDate(to requiredFormat: DateFormat) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let suitableFormat = DateFormat
      .allCases
      .first { (possibleFormat: DateFormat) -> Bool in
      dateFormatter.dateFormat = possibleFormat.rawValue
      return dateFormatter.date(from: self) != nil
      }?.rawValue ?? .empty
    
    dateFormatter.dateFormat = suitableFormat
    return dateFormatter.date(from: self) ?? Date()
  }
  
  func matches(_ regex: String) -> Bool {
      return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
  }
}
