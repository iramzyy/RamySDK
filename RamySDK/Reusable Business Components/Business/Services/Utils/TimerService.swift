//
//  TimerService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 15/04/2021.
//

import Foundation

public protocol TimerServiceProtocol: Service {
  func setTime(in seconds: TimeInterval)
  func start(timerTickHandler: Callback<String>?, finishHandler: VoidCallback?)
  func stop()
}

public final class TimerService: NSObject, TimerServiceProtocol {

  private var timer: Timer?
  private var currentDate: Date?
  private var timerTickHandler: Callback<String>?
  private var finishHandler: VoidCallback?

  private var isTimerEnd: Bool { remaininSeconds <= .zero }
  private let calendar = Calendar.autoupdatingCurrent

  private var remaininSeconds: TimeInterval {
    guard let currentDate = currentDate else { return 0 }
    return TimeInterval(Int(currentDate.timeIntervalSince(Date())))
  }

}

// MARK: - Public API

public extension TimerService {

  func setTime(in seconds: TimeInterval) {
    currentDate = Date().addingTimeInterval(seconds)
  }

  func start(timerTickHandler: Callback<String>?, finishHandler: VoidCallback?) {
    self.timerTickHandler = timerTickHandler
    self.finishHandler = finishHandler

    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    timer?.fire()
  }

  func stop() {
    timer?.invalidate()
  }
}

// MARK: - Logic

private extension TimerService {

  @objc private func timerTick() {
    guard let timerTickHandler = timerTickHandler, let currentDate = currentDate else { return }

    let components = calendar.dateComponents([.minute, .second], from: Date(), to: currentDate)
    let date = calendar.date(from: components)

    timerTickHandler(date!.format(with: .mmss))
    
    if isTimerEnd {
      endTime()
    }
  }

  private func endTime() {
    timer?.invalidate()
    finishHandler?()
  }
}
