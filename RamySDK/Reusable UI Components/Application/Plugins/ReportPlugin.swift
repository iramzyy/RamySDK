//
//  ReportPlugin.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 9/30/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIApplication

struct ReportPlugin {
  var services: [RunnableService] = [
    LogService.main
  ]
}

extension ReportPlugin: ApplicationPlugin {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    services.forEach { $0.start() }
    return true
  }
}
