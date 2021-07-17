//
//  SystemLogger.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/07/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import Foundation

public final class SystemLogger: LogEngine {
  public static let main: SystemLogger = .init()
  private init() { }
  
  public func info(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
  
  public func warn(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
  
  public func error(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
}
