//
//  Theme.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 31/05/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import UIKit

protocol RTheme: Colorable, FontCustomizable { }

public struct DefaultTheme: RTheme {
  var primary: BrandColor = PrimaryPalette()
  var secondary: BrandColor = SecondaryPalette()
  var monochromatic: Monochromatic = MonochromaticPalette()
  var transparency: Transparency = TransparencyPalette()
  var success: BrandColor = SuccessPalette()
  var warning: BrandColor = WarningPalette()
  var danger: BrandColor = DangerPalette()
  var info: BrandColor = InfoPalette()
  
  public func setupFont() -> FontManager {
    .init(configuration: .init())
  }
}
