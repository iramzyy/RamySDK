//
//  UI.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 31/05/2021.
//  Copyright © 2021 Nerdor. All rights reserved.
//

import UIKit

protocol Theme {
  var primary: BrandColor { get }
  var secondary: BrandColor { get }
  var monochromatic: Monochromatic { get }
  var transparency: Transparency { get }
  var success: BrandColor { get }
  var warning: BrandColor { get }
  var danger: BrandColor { get }
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

public struct LightTheme: Theme {
  var primary: BrandColor
  var secondary: BrandColor
  var monochromatic: Monochromatic
  var transparency: Transparency
  var success: BrandColor
  var warning: BrandColor
  var danger: BrandColor
}

public struct DarkTheme: Theme {
  var primary: BrandColor
  var secondary: BrandColor
  var monochromatic: Monochromatic
  var transparency: Transparency
  var success: BrandColor
  var warning: BrandColor
  var danger: BrandColor
}

public struct PrimaryColor: BrandColor {
  var `default`: UIColor = .init(named: "Primary.default")!
  var dark: UIColor  = .init(named: "Primary.dark")!
  var darkMode: UIColor = .init(named: "Primary.darkMode")!
  var light: UIColor = .init(named: "Primary.light")!
  var background: UIColor = .init(named: "Primary.background")!
}

public struct SecondaryColor: BrandColor {
  var `default`: UIColor = .init(named: "Secondary.default")!
  var dark: UIColor  = .init(named: "Secondary.dark")!
  var darkMode: UIColor = .init(named: "Secondary.darkMode")!
  var light: UIColor = .init(named: "Secondary.light")!
  var background: UIColor = .init(named: "Secondary.background")!
}

public struct SuccessColor: BrandColor {
  var `default`: UIColor = .init(named: "Secondary.default")!
  var dark: UIColor  = .init(named: "Secondary.dark")!
  var darkMode: UIColor = .init(named: "Secondary.darkMode")!
  var light: UIColor = .init(named: "Secondary.light")!
  var background: UIColor = .init(named: "Secondary.background")!
}

public struct WarningColor: BrandColor {
  var `default`: UIColor = .init(named: "Secondary.default")!
  var dark: UIColor  = .init(named: "Secondary.dark")!
  var darkMode: UIColor = .init(named: "Secondary.darkMode")!
  var light: UIColor = .init(named: "Secondary.light")!
  var background: UIColor = .init(named: "Secondary.background")!
}

public struct DangerColor: BrandColor {
  var `default`: UIColor = .init(named: "Secondary.default")!
  var dark: UIColor  = .init(named: "Secondary.dark")!
  var darkMode: UIColor = .init(named: "Secondary.darkMode")!
  var light: UIColor = .init(named: "Secondary.light")!
  var background: UIColor = .init(named: "Secondary.background")!
}

public struct TransparencyColor: Transparency {
  var light: UIColor = .init(named: "Light.Full")!
  var dark: UIColor = .init(named: "Dark.Full")!
  
  func light(by percentage: CGFloat) {
    light.withAlphaComponent(percentage / 100)
  }
  
  func dark(by percentage: CGFloat) {
    dark.withAlphaComponent(percentage / 100)
  }
}

public struct MonochromaticColor: Monochromatic {
  var offblack: UIColor = .init(named: "Monochromatic.offblack")!
  var body: UIColor = .init(named: "Monochromatic.body")!
  var label: UIColor = .init(named: "Monochromatic.label")!
  var placeholder: UIColor = .init(named: "Monochromatic.placeholder")!
  var line: UIColor = .init(named: "Monochromatic.line")!
  var input: UIColor = .init(named: "Monochromatic.input")!
  var background: UIColor = .init(named: "Monochromatic.background")!
  var offwhite: UIColor = .init(named: "Monochromatic.offwhite")!
}
