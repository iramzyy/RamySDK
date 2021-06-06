//
//  AppearancePlugin.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIApplication
import PKHUD

struct AppearancePlugin { }

extension AppearancePlugin: ApplicationPlugin {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    addAppearances()
    addHUDConfigs()
    return true
  }
  
  func addAppearances() {
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    // Sets shadow (line below the bar) to a blank image
    UINavigationBar.appearance().shadowImage = UIImage()
    // Sets the translucent background color
    UINavigationBar.appearance().backgroundColor = .clear
    // Set translucent. (Default value is already true, so this can be removed if desired.)
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().tintColor = R.color.primaryDefault()!
  }
  
  func addHUDConfigs() {
    HUD.allowsInteraction = true
  }
}
