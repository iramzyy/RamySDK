//
//  Logger.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

protocol Logger: class {
  func info(message: String)
  func warn(message: String)
  func error(message: String)
}

public enum LogTag: String {
  case `internal` = "[Internal]"
  case firebase = "[Firebase]"
  case realm = "[Realm]"
}

final class SystemLogger: Logger {
  func info(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
  
  func warn(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
  
  func error(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
}

enum LoggersManager {
  static func info(_ message: String, engines: [Logger] = [SystemLogger()]) {
    engines.forEach { $0.info(message: message) }
  }
  
  static func warn(_ message: String, engines: [Logger] = [SystemLogger()]) {
    engines.forEach { $0.warn(message: message) }
  }
  
  static func error(_ message: String, engines: [Logger] = [SystemLogger()]) {
    engines.forEach { $0.error(message: message) }
  }
}

public extension String {
  func tagWith(_ tag: LogTag, _ functionName: String = #function) -> String {
    self.withPrefix("\(tag.rawValue)-\(functionName) ")
  }
}
