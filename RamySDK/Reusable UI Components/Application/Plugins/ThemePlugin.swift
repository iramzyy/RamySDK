//
//  ThemePlugin.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 02/06/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import UIKit.UIApplication

struct ThemePlugin { }

extension ThemePlugin: ApplicationPlugin {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    setupTheme()
    return true
  }
  
  private func setupTheme() {
    ThemeManager.shared.setup()
  }
}
