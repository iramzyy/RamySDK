//
//  UITextField+Extensions.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UITextField

extension UITextField {
  private struct StoredProperties {
    static var padding: UIEdgeInsets = .zero
  }
}

public extension UITextField {
  @objc var padding: UIEdgeInsets {
    get {
      return getAssociatedObject(&StoredProperties.padding, defaultValue: .zero)
    }
    set {
      objc_setAssociatedObject(self, &StoredProperties.padding, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }
  
  enum Direction {
    case right
    case left
  }
  
  enum State: Equatable {
    case inactive
    case focused
    case disabled
  }
  
  func accessoryView(direction: Direction, view: UIView) {
    let topOffset: CGFloat = (Dimensions.Fields.TextFields.height - Dimensions.Fields.TextFields.accessorySize.width) / 2
    let rtlOffset: CGFloat = Dimensions.Fields.TextFields.accessorySize.width - Dimensions.Fields.TextFields.iconSize.width
    let ltrOffset: CGFloat = 0
    let desiredOffset = UILocalization.shared.isRTLLanguage ? rtlOffset : ltrOffset
    view.frame = CGRect(x: desiredOffset, y: topOffset + 5 ,
                        width: Dimensions.Fields.TextFields.iconSize.width,
                        height: Dimensions.Fields.TextFields.iconSize.height)

    let accessoryContainerView = UIView(frame: CGRect(x: 0, y: 0,
                                                      width: Dimensions.Fields.TextFields.accessorySize.width,
                                                      height: Dimensions.Fields.TextFields.height))
    accessoryContainerView.addSubview(view)
    
    if direction == .left {
      leftView = accessoryContainerView
      leftViewMode = .always
    } else {
      rightView = accessoryContainerView
      rightViewMode = .always
    }
  }

  func icon(direction: Direction, image: UIImage, tintColor: UIColor, action: VoidCallback? = nil) {
    let button = UIButton(type: .system).then {
      $0.setImage(image, for: .normal)
      $0.tintColor = tintColor
      if action != nil {
        $0.setControlEvent(.touchUpInside) {
          action?()
        }
      }
    }

    accessoryView(direction: direction, view: button)
  }

  func removeAccessoryView(direction: Direction) {
    if direction == .left {
      leftView = nil
      leftViewMode = .never
    } else {
      rightView = nil
      rightViewMode = .never
    }
  }
  
  func calculatePadding() -> UIEdgeInsets {
    var tempPadding: UIEdgeInsets = padding

    if UserSettingsService.shared.language.value?.isRTLLanguage ?? false {
      if leftViewMode == .always {
        tempPadding = UIEdgeInsets(top: tempPadding.top,
                                   left: tempPadding.left,
                                   bottom: tempPadding.bottom,
                                   right: Dimensions.Fields.TextFields.accessorySize.width)
      }

      if rightViewMode == .always {
        tempPadding = UIEdgeInsets(top: tempPadding.top,
                                   left: Dimensions.Fields.TextFields.accessorySize.width,
                                   bottom: tempPadding.bottom,
                                   right: tempPadding.right)
      }
    } else {
      if leftViewMode == .always {
        tempPadding = UIEdgeInsets(top: tempPadding.top,
                                   left: Dimensions.Fields.TextFields.accessorySize.width,
                                   bottom: tempPadding.bottom,
                                   right: tempPadding.right)
      }

      if rightViewMode == .always {
        tempPadding = UIEdgeInsets(top: tempPadding.top,
                                   left: tempPadding.left,
                                   bottom: tempPadding.bottom,
                                   right: Dimensions.Fields.TextFields.accessorySize.width)
      }
    }
    
    return tempPadding
  }
  
  func paddingRect(for bounds: CGRect) -> CGRect {
    return bounds.inset(by: calculatePadding())
  }
}
