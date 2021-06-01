//
//  Fontable.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 01/06/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import UIKit

protocol FontCustomizable {
  func setupFont() -> FontManager
}

enum FontType {
  case sansSerif
  case serif
}

enum FontCategory {
  /// Big Titles and large pieces of texts
  case display
  /// Moderate Text
  case text
  /// Small texts like captions and links
  case link
}

enum FontScale {
  case huge
  case large
  case medium
  case small
  case xsmall
}

enum FontWeight {
  case regular
  case bold
}

enum FontLocale {
  case english
  case arabic
  
  init(language: Language) {
    switch language {
    case .english:
      self = .english
    case .arabic:
      self = .arabic
    }
  }
  
  func toLanguage() -> Language {
    switch self {
    case .english:
      return .english
    case .arabic:
      return .arabic
    }
  }
}

protocol NFontDetailsProtocol {
  var name: String { get }
  var fontLocale: FontLocale { get }
  var fontType: FontType { get }
}

protocol NFontProtocol {
  var fontDetails: NFontDetailsProtocol { get set }
  var fontCategory: FontCategory { get set }
  var fontScale: FontScale { get set }
  var fontWeight: FontWeight { get set }
  var font: UIFont { get }
  var metrics: NFontMetrics { get }
}

extension NFontProtocol {
  var metrics: NFontMetrics {
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
    let fontName = "\(fontDetails.name)\(mapWeight(weight: fontWeight))"
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

protocol NFontMetricsProtocol {
  var size: CGFloat { get }
  var lineHeight: CGFloat { get }
  var letterSpacing: CGFloat { get }
}

struct NFontMetrics: NFontMetricsProtocol {
  let size: CGFloat
  let lineHeight: CGFloat
  let letterSpacing: CGFloat
}

public struct NFontDetails: NFontDetailsProtocol {
  var name: String
  var fontLocale: FontLocale
  var fontType: FontType
}

public struct NFont: NFontProtocol {
  var fontDetails: NFontDetailsProtocol
  var fontCategory: FontCategory
  var fontScale: FontScale
  var fontWeight: FontWeight
}

final class FontManager {
  static var shared: FontManager!
  var configuration: Configuration
  
  init(configuration: Configuration) {
    self.configuration = configuration
  }
  
  func getSuitableFont(
    category: FontCategory,
    scale: FontScale,
    weight: FontWeight
  ) -> NFontProtocol {
    guard let suitableFont = availableFonts
            .first(where: { $0.fontLocale == configuration.fontsLocale && $0.fontType == configuration.fontsType })
    else { fatalError("Can't find a suitable font to set") }
    
    return NFont(fontDetails: suitableFont, fontCategory: category, fontScale: scale, fontWeight: weight)
  }
  
  func getFont(
    locale: FontLocale,
    type: FontType,
    category: FontCategory,
    scale: FontScale,
    weight: FontWeight
  ) -> NFontProtocol {
    guard let suitableFont = availableFonts
            .first(where: { $0.fontLocale == locale && $0.fontType == type })
    else { return getSuitableFont(category: category, scale: scale, weight: weight) }
    
    return NFont(fontDetails: suitableFont, fontCategory: category, fontScale: scale, fontWeight: weight)
  }
}

extension FontManager {
  struct Configuration: Codable {
    var fontsLocale: FontLocale = .english
    var fontsType: FontType = .sansSerif
    var availableFonts: [NFontDetails] = []
  }
}
