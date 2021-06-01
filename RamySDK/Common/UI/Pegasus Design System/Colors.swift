//
//  Colors.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 01/06/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import UIKit

protocol Colorable {
  var primary: BrandColor { get }
  var secondary: BrandColor { get }
  var monochromatic: Monochromatic { get }
  var transparency: Transparency { get }
  var success: BrandColor { get }
  var warning: BrandColor { get }
  var danger: BrandColor { get }
  var info: BrandColor { get }
}

protocol BrandColor {
  var `default`: UIColor { get }
  var dark: UIColor { get }
  var darkMode: UIColor { get }
  var light: UIColor { get }
  var background: UIColor { get }
}

protocol Monochromatic {
  var offblack: UIColor { get }
  var body: UIColor { get }
  var label: UIColor { get }
  var placeholder: UIColor { get }
  var line: UIColor { get }
  var input: UIColor { get }
  var background: UIColor { get }
  var offwhite: UIColor { get }
}

protocol Transparency {
  var light: UIColor { get }
  var dark: UIColor { get }
  
  func light(by percentage: CGFloat)
  func dark(by percentage: CGFloat)
}

public struct PrimaryPalette: BrandColor {
  var `default`: UIColor = .init(named: "Primary.default")!
  var dark: UIColor  = .init(named: "Primary.dark")!
  var darkMode: UIColor = .init(named: "Primary.darkMode")!
  var light: UIColor = .init(named: "Primary.light")!
  var background: UIColor = .init(named: "Primary.background")!
}

public struct SecondaryPalette: BrandColor {
  var `default`: UIColor = .init(named: "Secondary.default")!
  var dark: UIColor  = .init(named: "Secondary.dark")!
  var darkMode: UIColor = .init(named: "Secondary.darkMode")!
  var light: UIColor = .init(named: "Secondary.light")!
  var background: UIColor = .init(named: "Secondary.background")!
}

public struct SuccessPalette: BrandColor {
  var `default`: UIColor = .init(named: "Success.default")!
  var dark: UIColor  = .init(named: "Success.dark")!
  var darkMode: UIColor = .init(named: "Success.darkMode")!
  var light: UIColor = .init(named: "Success.light")!
  var background: UIColor = .init(named: "Success.background")!
}

public struct WarningPalette: BrandColor {
  var `default`: UIColor = .init(named: "Warning.default")!
  var dark: UIColor  = .init(named: "Warning.dark")!
  var darkMode: UIColor = .init(named: "Warning.darkMode")!
  var light: UIColor = .init(named: "Warning.light")!
  var background: UIColor = .init(named: "Warning.background")!
}

public struct DangerPalette: BrandColor {
  var `default`: UIColor = .init(named: "Danger.default")!
  var dark: UIColor  = .init(named: "Danger.dark")!
  var darkMode: UIColor = .init(named: "Danger.darkMode")!
  var light: UIColor = .init(named: "Danger.light")!
  var background: UIColor = .init(named: "Danger.background")!
}

public struct InfoPalette: BrandColor {
  var `default`: UIColor = .init(named: "Info.default")!
  var dark: UIColor  = .init(named: "Info.dark")!
  var darkMode: UIColor = .init(named: "Info.darkMode")!
  var light: UIColor = .init(named: "Info.light")!
  var background: UIColor = .init(named: "Info.background")!
}

public struct TransparencyPalette: Transparency {
  var light: UIColor = .init(named: "Light.full")!
  var dark: UIColor = .init(named: "Dark.full")!
  
  func light(by percentage: CGFloat) {
    light.withAlphaComponent(percentage / 100)
  }
  
  func dark(by percentage: CGFloat) {
    dark.withAlphaComponent(percentage / 100)
  }
}

public struct MonochromaticPalette: Monochromatic {
  var offblack: UIColor = .init(named: "Monochromatic.offblack")!
  var body: UIColor = .init(named: "Monochromatic.body")!
  var label: UIColor = .init(named: "Monochromatic.label")!
  var placeholder: UIColor = .init(named: "Monochromatic.placeholder")!
  var line: UIColor = .init(named: "Monochromatic.line")!
  var input: UIColor = .init(named: "Monochromatic.input")!
  var background: UIColor = .init(named: "Monochromatic.background")!
  var offwhite: UIColor = .init(named: "Monochromatic.offwhite")!
}
