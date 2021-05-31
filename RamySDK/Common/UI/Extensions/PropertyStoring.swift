//
//  PropertyStoring.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import Foundation

public protocol PropertyStoring {
  func getAssociatedObject<T>(_ key: UnsafeRawPointer!, defaultValue: T) -> T
}

public extension PropertyStoring {
  func getAssociatedObject<T>(_ key: UnsafeRawPointer!, defaultValue: T) -> T {
    guard let value = objc_getAssociatedObject(self, key) as? T else {
      return defaultValue
    }
    
    return value
  }
}
