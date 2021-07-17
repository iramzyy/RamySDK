//
//  LogService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/07/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import Pulse
import Logging

public protocol RunnableService: Service {
  func start()
}

public final class LogService: RunnableService {
  public static let main: LogService = .init()
  public func start() {
    LoggingSystem.bootstrap(PersistentLogHandler.init)
    SentryService.main.start()
    LoggersManager.info("Loggers Woke Up!")
  }
}
