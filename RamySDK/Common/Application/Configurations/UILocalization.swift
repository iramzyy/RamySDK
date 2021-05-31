//
//  UILocalization.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public struct UILocalization {
  static let shared = UILocalization(isRTLLanguage: UserSettingsService.shared.language.value?.isRTLLanguage ?? false)
  public let isRTLLanguage: Bool

  public var writingDirection: NSWritingDirection {
    return isRTLLanguage ? .rightToLeft : .leftToRight
  }

  public var semanticContentAttribute: UISemanticContentAttribute {
    return isRTLLanguage ? .forceRightToLeft : .forceLeftToRight
  }
  
  public var textAlignment: NSTextAlignment {
    return isRTLLanguage ? .right : .left
  }
  
  public var reversedTextAlignment: NSTextAlignment {
    return isRTLLanguage ? .left : .right
  }
  
  public var reversedWritingDirection: NSWritingDirection {
    return isRTLLanguage ? .leftToRight : .rightToLeft
  }
  
  public var reversedSemanticContentAttribute: UISemanticContentAttribute {
    return isRTLLanguage ? .forceLeftToRight : .forceRightToLeft
  }
}
