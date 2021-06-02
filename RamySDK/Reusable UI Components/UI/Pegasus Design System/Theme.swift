//
//  Theme.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 31/05/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import UIKit

public protocol RTheme: Colorable, FontCustomizable { }

public struct DefaultTheme: RTheme {
  public var primary: BrandColor = PrimaryPalette()
  public var secondary: BrandColor = SecondaryPalette()
  public var monochromatic: Monochromatic = MonochromaticPalette()
  public var transparency: Transparency = TransparencyPalette()
  public var success: BrandColor = SuccessPalette()
  public var warning: BrandColor = WarningPalette()
  public var danger: BrandColor = DangerPalette()
  public var info: BrandColor = InfoPalette()
  
  public func setupFont() -> FontManager {
    guard let url = Bundle.main.url(forResource: "fonts", withExtension: "json") else { fatalError() }
    do {
      let data = try Data(contentsOf: url)
      let configs = try JSONDecoder().decode(ConfigFonts.self, from: data)
      return FontManager(
        configuration: FontManager.Configuration(
          fontsLocale: configs.defaultConfigurations.sdkFriendlyLocale(),
          fontsType: configs.defaultConfigurations.sdkFriendlyType(),
          availableFonts: configs.fonts.map { $0.toSDKFont() }
        )
      )
    } catch {
      LoggersManager.error(error.localizedDescription)
      fatalError(error.localizedDescription)
    }
  }
}

public final class ThemeManager {
  public var selectedTheme: RTheme = DefaultTheme()
  public var supportedThemes: [RTheme] = [DefaultTheme()]
  public static var shared: ThemeManager = .init()
  
  public init() {
    setup()
  }
  
  public func setup() {
    FontManager.shared = selectedTheme.setupFont()
  }
}
