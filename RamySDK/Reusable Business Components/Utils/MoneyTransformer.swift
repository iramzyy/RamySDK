//
//  MoneyTransformer.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 06/04/2021.
//

import Foundation

class MoneyTransformer {
  static func format(amount: Double, minimumFractionDigits: Int = DoubleRepresentation.minimumFractionDigits, withCurrency: Bool = false) -> String {
    let formattedPrice = amount.formatForPrice()
    return withCurrency ? formattedPrice.suffixCurrency() : formattedPrice
  }
}

private extension Double {
  func formatForPrice() -> String {
    let formatter = NumberFormatter().then {
      $0.minimumFractionDigits = 2
    }
    return formatter.string(from: NSNumber(value: self)) ?? "0.00"
  }
}
