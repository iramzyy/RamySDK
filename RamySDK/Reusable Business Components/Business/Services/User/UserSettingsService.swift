//
//  UserSettingsService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

protocol UserSettings {
  var language: Dynamic<Language> { get }
  var currency: Dynamic<String> { get }
}

final class UserSettingsService: UserSettings {
  static var shared: UserSettings = UserSettingsService()
  
  lazy var language: Dynamic<Language> = {
    let deviceLanguageCode = Bundle.main.preferredLocalizations.first
    let deviceLanguage = Language(localeLanguageCode: deviceLanguageCode ?? "en")
    return Dynamic<Language>(deviceLanguage)
  }()
  
  lazy var currency: Dynamic<String> = {
    return Dynamic<String>("EGP")
  }()
}
