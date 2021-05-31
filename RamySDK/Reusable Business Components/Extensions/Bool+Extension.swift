//
//  Bool+Extension.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 01/05/2021.
//

import Foundation

public extension Bool {
  func toReadable() -> String {
    self ? "Yes".localized() : "No".localized()
  }
}
