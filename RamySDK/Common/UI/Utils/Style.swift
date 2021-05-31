//
//  Style.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIColor

public protocol Style {
  var textColor: UIColor { get }
  var backgroundColor: UIColor { get }
  var borderColor: UIColor? { get }
  var borderWidth: CGFloat? { get }
}
