//
//  SentryManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 29/06/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import Sentry

public final class SentryService: RunnableService {
  public static let main = SentryService()
  
  public var isRunning: Bool = false
  
  public var logEngine: LogEngine? {
    isRunning ? SentryLogger() : nil
  }
  
  private init() { }
  
  public func start() {
    SentrySDK.start { options in
      options.dsn = Configurations.default.dsn
      options.debug = Configurations.default.debug
      options.environment = Configurations.default.environment
      options.tracesSampleRate = Configurations.default.traceSampleRate
    }
    
    isRunning = true
  }
}

fileprivate extension SentryService {
  struct Configurations {
    let dsn: String
    let debug: Bool
    let traceSampleRate: NSNumber    
    
    #if DEBUG
    let environment: String = "Development"
    #elseif STAGING
    let environment: String = "Staging"
    #else
    let environment: String = "Production"
    #endif
    
    static let `default`: Configurations = .init(
      dsn: "https://a3ed9c032dbe4325a91db46be4699a63@o891148.ingest.sentry.io/5839800",
      debug: false,
      traceSampleRate: 1.0
    )
  }
}

public extension SentryService {
  final class SentryLogger: LogEngine {
    private func createEvent(level: SentryLevel, message: String) -> Event {
      let level: SentryLevel = .info
      let event = Event(level: level)
      event.message = SentryMessage(formatted: message)
      return event
    }
    public func info(message: String) {
      SentrySDK.capture(event: createEvent(level: .info, message: message))
    }
    
    public func warn(message: String) {
      SentrySDK.capture(event: createEvent(level: .warning, message: message))
    }
    
    public func error(message: String) {
      SentrySDK.capture(event: createEvent(level: .error, message: message))
    }
  }
}
