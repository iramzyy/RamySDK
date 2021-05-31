//
//  Array+Extensions.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/04/2021.
//

import Foundation

extension Array {
  func betweenEachTwo(insert separator: Element) -> [Element] {
    self.map { [$0] }.joined(separator: [separator]).compactMap { $0 }
  }
}
