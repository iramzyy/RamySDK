//
//  AppCenterPlugin.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 28/04/2021.
//

import AppCenter
import UIKit

struct AppCenterPlugin { }

extension AppCenterPlugin: ApplicationPlugin {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    setupAppCenter()
    return true
  }
  
  private func setupAppCenter() {
    AppCenter.start(withAppSecret: Secret.appCenterKey, services: [])
  }
}
