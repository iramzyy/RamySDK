//
//  TextStyles.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

/// Enum with static fonts that matches HIG's metrics
/// To Check the metrics, u can check the FontManager
public enum TextStyles {
  public static let displayHuge: FontProtocol = FontManager.shared.getSuitableFont(category: .display, scale: .huge, weight: .regular)
  public static let displayLarge: FontProtocol = FontManager.shared.getSuitableFont(category: .display, scale: .large, weight: .regular)
  public static let displayMedium: FontProtocol = FontManager.shared.getSuitableFont(category: .display, scale: .medium, weight: .regular)
  public static let displaySmall: FontProtocol = FontManager.shared.getSuitableFont(category: .display, scale: .small, weight: .regular)
  
  public static let displayHugeBold: FontProtocol = FontManager.shared.getSuitableFont(category: .display, scale: .huge, weight: .bold)
  public static let displayLargeBold: FontProtocol = FontManager.shared.getSuitableFont(category: .display, scale: .large, weight: .bold)
  public static let displayMediumBold: FontProtocol = FontManager.shared.getSuitableFont(category: .display, scale: .medium, weight: .bold)
  public static let displaySmallBold: FontProtocol = FontManager.shared.getSuitableFont(category: .display, scale: .small, weight: .bold)
  
  public static let textHuge: FontProtocol = FontManager.shared.getSuitableFont(category: .text, scale: .huge, weight: .regular)
  public static let textLarge: FontProtocol = FontManager.shared.getSuitableFont(category: .text, scale: .large, weight: .regular)
  public static let textMedium: FontProtocol = FontManager.shared.getSuitableFont(category: .text, scale: .medium, weight: .regular)
  public static let textSmall: FontProtocol = FontManager.shared.getSuitableFont(category: .text, scale: .small, weight: .regular)
  
  public static let linkHuge: FontProtocol = FontManager.shared.getSuitableFont(category: .link, scale: .huge, weight: .bold)
  public static let linkLarge: FontProtocol = FontManager.shared.getSuitableFont(category: .link, scale: .large, weight: .bold)
  public static let linkMedium: FontProtocol = FontManager.shared.getSuitableFont(category: .link, scale: .medium, weight: .bold)
  public static let linkSmall: FontProtocol = FontManager.shared.getSuitableFont(category: .link, scale: .small, weight: .bold)
}
