//
//  LoggerManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

public protocol LogEngine {
  func info(message: String)
  func warn(message: String)
  func error(message: String)
}

public enum LogTag: String {
  case `internal` = "[Internal]"
  case firebase = "[Firebase]"
  case realm = "[Realm]"
  case network = "[Network]"
  case imageDownload = "[Image Download]"
}

public struct LoggersManager {
  private static var engines: [LogEngine] {
    [
      PulseLogger.main,
      SystemLogger.main,
      SentryService.main.logEngine
    ].compactMap { $0 }
  }
  
  public static func info(_ message: String) {
    engines.forEach { $0.info(message: message) }
  }
  
  public static func warn(_ message: String) {
    engines.forEach { $0.warn(message: message) }
  }
  
  public static func error(_ message: String) {
    engines.forEach { $0.error(message: message) }
  }
}

public extension String {
  func tagWith(_ tag: LogTag) -> String {
    self.withPrefix("[\(tag.rawValue)] ")
  }
}
