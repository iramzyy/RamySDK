//
//  PulseService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/07/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import Pulse
import Foundation

public final class PulseService: Service {
  public static let main: PulseService = .init()
  
  public func setup(sessionDelegate: URLSessionDelegate) -> URLSession {
    let proxyDelegate = URLSessionProxyDelegate(delegate: sessionDelegate)
    return URLSession(configuration: .default, delegate: proxyDelegate, delegateQueue: nil)
  }
}
