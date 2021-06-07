//
//  NSAttributedStringBuilder.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public class NSAttributedStringBuilder {
  private var attributedString = NSMutableAttributedString()
  
  private func wholeString() -> NSRange {
    .init(location: 0, length: attributedString.string.utf16.count)
  }
  
  @discardableResult
  public func add(text: String)-> NSAttributedStringBuilder {
    attributedString.append(NSAttributedString(string: text))
    return self
  }
  
  @discardableResult
  public func add(foregroundColor: UIColor)-> NSAttributedStringBuilder {
    attributedString.addAttribute(.foregroundColor, value: foregroundColor, range: wholeString())
    return self
  }
  
  @discardableResult
  public func add(foregroundColor: UIColor, for string: String)-> NSAttributedStringBuilder {
    guard let substringRange = attributedString.string.range(of: string) else { return self }
    let range = NSRange(substringRange, in: attributedString.string)
    attributedString.addAttribute(.foregroundColor, value: foregroundColor, range: range)
    return self
  }
  
  @discardableResult
  public func add(font: Font, for string: String) -> NSAttributedStringBuilder {
    guard let substringRange = attributedString.string.range(of: string) else { return self }
    let range = NSRange(substringRange, in: attributedString.string)
    attributedString.addAttribute(.font, value: font, range: range)
    let style = NSMutableParagraphStyle().then {
      $0.lineHeightMultiple = font.metrics.lineHeight
      $0.minimumLineHeight = font.metrics.lineHeight
      $0.maximumLineHeight = font.metrics.lineHeight
      $0.lineSpacing = font.metrics.letterSpacing
    }
    attributedString.addAttribute(.paragraphStyle, value: style, range: range)
    return self
  }
  
  @discardableResult
  public func add(font: Font) -> NSAttributedStringBuilder {
    let range = wholeString()
    attributedString.addAttribute(.font, value: font.accessibleFont, range: range)
    let style = NSMutableParagraphStyle().then {
      $0.lineHeightMultiple = font.accessibleLineHeight
      $0.minimumLineHeight = font.accessibleLineHeight
      $0.maximumLineHeight = font.accessibleLineHeight
      $0.lineSpacing = font.accessibleLetterSpacing
    }
    attributedString.addAttribute(.paragraphStyle, value: style, range: range)
    return self
  }
  
  @discardableResult
  public func add(underlineFor string: String)-> NSAttributedStringBuilder {
    guard let substringRange = attributedString.string.range(of: string) else { return self }
    let range = NSRange(substringRange, in: attributedString.string)
    attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single, range: range)
    return self
  }
  
  public func build() -> NSAttributedString {
    attributedString.attributedSubstring(from: wholeString())
  }
}
