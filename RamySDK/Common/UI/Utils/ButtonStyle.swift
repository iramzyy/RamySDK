//
//  ButtonStyle.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public protocol ButtonStyle: Style {
  var iconColor: UIColor { get }
  var shouldPutIconInFarEdge: Bool { get }
}

extension ButtonStyle {
  var shouldPutIconInFarEdge: Bool { false }
}

struct PrimaryButtonStyle: ButtonStyle {
  var textColor: UIColor {
    R.color.primaryButtonTextColor() ?? .red
  }
  
  var backgroundColor: UIColor {
    R.color.primaryButtonBackgroundColor() ?? .red
  }
  
  var iconColor: UIColor {
    R.color.primaryButtonIconColor() ?? .red
  }
  
  var borderColor: UIColor? {
    nil
  }
  
  var borderWidth: CGFloat? {
    nil
  }
}

struct SecondaryButtonStyle: ButtonStyle {
  var textColor: UIColor {
    R.color.secondaryButtonTextColor() ?? .red
  }
  
  var backgroundColor: UIColor {
    R.color.secondaryButtonBackgroundColor() ?? .red
  }
  
  var iconColor: UIColor {
    R.color.secondaryButtonIconColor() ?? .red
  }
  
  var borderColor: UIColor? {
    nil
  }
  
  var borderWidth: CGFloat? {
    nil
  }
}

struct DisabledButtonStyle: ButtonStyle {
  var textColor: UIColor {
    .black // TODO: - Move to Assets later on
  }
  
  var backgroundColor: UIColor {
    .lightGray // TODO: - Move to Assets
  }
  
  var iconColor: UIColor {
    .darkGray
  }
  
  var borderColor: UIColor? {
    nil
  }
  
  var borderWidth: CGFloat? {
    nil
  }
}

struct SettingsButtonStyle: ButtonStyle {
  var textColor: UIColor { .black }
  
  var backgroundColor: UIColor { .clear }
  
  var iconColor: UIColor { R.color.separatorColor() ?? .red }
  
  var borderColor: UIColor? { R.color.separatorColor() ?? .red }
  
  var borderWidth: CGFloat? { 1 }
  
  var shouldPutIconInFarEdge: Bool { true }
}

struct DestructiveButtonStyle: ButtonStyle {
  var textColor: UIColor { .white }
  
  var backgroundColor: UIColor { .red }
  
  var iconColor: UIColor { .white }
  
  var borderColor: UIColor? { nil }
  
  var borderWidth: CGFloat? { nil }
}

struct OverlayButtonStyle: ButtonStyle {
  var textColor: UIColor { .clear }
  
  var backgroundColor: UIColor { .clear }
  
  var iconColor: UIColor { .clear }
  
  var borderColor: UIColor? { nil }
  
  var borderWidth: CGFloat? { nil }
}
