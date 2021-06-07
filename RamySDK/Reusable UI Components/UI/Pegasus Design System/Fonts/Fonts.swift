//
//  Fontable.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 01/06/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import UIKit

public protocol FontCustomizable {
  func setupFont() -> FontManager
}

public enum FontType: String,  Codable {
  case sansSerif
  case serif
  
  init(string: String) {
    switch string {
    case "sans-serif":
    self = .sansSerif
    case "serif":
      self = .serif
    default:
      self = .sansSerif
    }
  }
}

public enum FontCategory: String, Codable {
  /// Big Titles and large pieces of texts
  /// Font Sizes: 34 - 20
  case display
  /// Moderate Text
  /// Font Sizes: 20 - 13
  case text
  /// Small texts like captions and links
  /// Font Sizes: 20 - 13
  case link
}

public enum FontScale: String, Codable {
  /// Display -> 34
  /// Text -> 20
  /// Link -> 20
  case huge
  /// Display -> 28
  /// Text -> 20
  /// Link -> 20
  case large
  /// Display -> 24
  /// Text -> 17
  /// Link -> 17
  case medium
  /// Display -> 20
  /// Text -> 15
  /// Link -> 15
  case small
  /// Display -> 20
  /// Text -> 13
  /// Link -> 13
  case xsmall
}

public enum FontWeight: String, Codable {
  case regular
  case bold
}

public enum FontLocale: String, Codable {
  case english
  case arabic
  
  public init(language: Language) {
    switch language {
    case .english:
      self = .english
    case .arabic:
      self = .arabic
    }
  }
  
  public init(string: String) {
    switch string {
    case "arabic":
      self = .arabic
    case "english":
      self = .english
    default:
      self = .english
    }
  }
  
  public func toLanguage() -> Language {
    switch self {
    case .english:
      return .english
    case .arabic:
      return .arabic
    }
  }
}

public protocol FontProtocol: Codable {
  var fontDetails: FontDetails { get set }
  var fontCategory: FontCategory { get set }
  var fontScale: FontScale { get set }
  var fontWeight: FontWeight { get set }
  var font: UIFont { get }
  var metrics: FontMetrics { get }
}

public extension FontProtocol {
  var metrics: FontMetrics {
    switch fontCategory {
    case .display:
      switch fontScale {
      case .huge:
        return .init(size: 34, lineHeight: 48, letterSpacing: 1)
      case .large:
        return .init(size: 28, lineHeight: 40, letterSpacing: 1)
      case .medium:
        return .init(size: 24, lineHeight: 34, letterSpacing: 1)
      case .small, .xsmall:
        return .init(size: 20, lineHeight: 32, letterSpacing: 1)
      }
    case .text:
      switch fontScale {
      case .huge,
           .large:
        return .init(size: 20, lineHeight: 32, letterSpacing: 0.75)
      case .medium:
        return .init(size: 17, lineHeight: 28, letterSpacing: 0.75)
      case .small:
        return .init(size: 15, lineHeight: 24, letterSpacing: 0.75)
      case .xsmall:
        return .init(size: 13, lineHeight: 22, letterSpacing: 0.25)
      }
    case .link:
      switch fontScale {
      case .huge,
           .large:
        return .init(size: 20, lineHeight: 32, letterSpacing: 0.75)
      case .medium:
        return .init(size: 17, lineHeight: 28, letterSpacing: 0.75)
      case .small:
        return .init(size: 15, lineHeight: 24, letterSpacing: 0.75)
      case .xsmall:
        return .init(size: 13, lineHeight: 22, letterSpacing: 0.25)
      }
    }
  }
  
  var font: UIFont {
    let fontName = "\(fontDetails.name)-\(mapWeight(weight: fontWeight))"
    return UIFont(name: fontName, size: metrics.size) ?? .systemFont(ofSize: metrics.size)
  }
  
  private func mapWeight(weight: FontWeight) -> String {
    switch weight {
    case .bold:
      return "Bold"
    case .regular:
      return "Regular"
    }
  }
}

public protocol FontMetricsProtocol {
  var size: CGFloat { get }
  var lineHeight: CGFloat { get }
  var letterSpacing: CGFloat { get }
}

public struct FontMetrics: Codable, FontMetricsProtocol {
  public let size: CGFloat
  public let lineHeight: CGFloat
  public let letterSpacing: CGFloat
}

public struct FontDetails: Codable {
  public var name: String
  public var fontLocale: FontLocale
  public var fontType: FontType
  
  public init(name: String, fontLocale: FontLocale, fontType: FontType) {
    self.name = name
    self.fontLocale = fontLocale
    self.fontType = fontType
  }
}

public struct Font: FontProtocol {
  public var fontDetails: FontDetails
  public var fontCategory: FontCategory
  public var fontScale: FontScale
  public var fontWeight: FontWeight
}

public extension Font {
  static let header: Font = FontManager.shared.getSuitableFont(category: .display, scale: .huge, weight: .bold)
  static let title: Font = FontManager.shared.getSuitableFont(category: .display, scale: .large, weight: .bold)
  static let body: Font = FontManager.shared.getSuitableFont(category: .text, scale: .medium, weight: .regular)
}

public final class FontManager {
  static var shared: FontManager!
  var configuration: Configuration
  
  init(configuration: Configuration) {
    self.configuration = configuration
  }
  
  func getSuitableFont(
    category: FontCategory,
    scale: FontScale,
    weight: FontWeight
  ) -> Font {
    guard let suitableFont = configuration.availableFonts
            .first(where: { $0.fontLocale == configuration.fontsLocale && $0.fontType == configuration.fontsType })
    else { fatalError("Can't find a suitable font to set") }
    
    return Font(fontDetails: suitableFont, fontCategory: category, fontScale: scale, fontWeight: weight)
  }
  
  func getFont(
    locale: FontLocale,
    type: FontType,
    category: FontCategory,
    scale: FontScale,
    weight: FontWeight
  ) -> Font {
    guard let suitableFont = configuration.availableFonts
            .first(where: { $0.fontLocale == locale && $0.fontType == type })
    else { return getSuitableFont(category: category, scale: scale, weight: weight) }
    
    return Font(fontDetails: suitableFont, fontCategory: category, fontScale: scale, fontWeight: weight)
  }
}

public extension FontManager {
  struct Configuration: Codable {
    var fontsLocale: FontLocale = .english
    var fontsType: FontType = .sansSerif
    var availableFonts: [FontDetails] = []
  }
}

public protocol AccessibilityFont {
  /// Dynamically scalled font for FontStyle.
  var accessibleFont: UIFont { get }
}

extension Font: AccessibilityFont {
  private func getMappedTextStyle() -> UIFont.TextStyle {
    switch (self.fontCategory, self.fontScale, self.fontWeight) {
    case (.display, .huge, _):
      return .largeTitle
    case (.display, .large, _):
      return .title1
    case (.display, .medium, _):
      return .title2
    case (.display, .small, _),
         (.display, .xsmall, _),
         (.text, .huge, _),
         (.link, .huge, _),
         (.text, .large, _),
         (.link, .large, _):
      return .title3
    case (.text, .medium, .bold),
         (.link, .medium, .bold):
      return .headline
    case (.text, .medium, .regular),
         (.link, .medium, .regular):
      return .body
    case (.text, .small,_):
      return .subheadline
    case (.text, .xsmall, _):
      return .footnote
    case (.link, .small,_):
      return .subheadline
    case (.link, .xsmall, _):
      return .footnote
    }
  }
  
  public var accessibleFont: UIFont {
    UIFontMetrics(forTextStyle: getMappedTextStyle()).scaledFont(for: font)
  }
  
  public var accessibleLineHeight: CGFloat {
    UIFontMetrics(forTextStyle: getMappedTextStyle()).scaledValue(for: metrics.lineHeight)
  }
  
  public var accessibleLetterSpacing: CGFloat {
    UIFontMetrics(forTextStyle: getMappedTextStyle()).scaledValue(for: metrics.letterSpacing)
  }
}
