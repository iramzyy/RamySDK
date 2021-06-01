//
//  SessionTimerService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 30/04/2021.
//

import Foundation

public protocol SessionTimerServiceProtocol: Service {
  var onTimerFinish: VoidCallback? { get set }
}

public final class SessionTimerService: SessionTimerServiceProtocol {
  private let timer: TimerServiceProtocol
  public var onTimerFinish: VoidCallback?
  
  public init(timer: TimerServiceProtocol = TimerService()) {
    self.timer = timer
    monitorTime()
  }
}

private extension SessionTimerService {
  func monitorTime() {
    self.timer.setTime(in: BiometricTimer.interval)
    self.timer.start(timerTickHandler: nil) { [weak self] in
      self?.onTimerFinish?()
    }
  }
}
