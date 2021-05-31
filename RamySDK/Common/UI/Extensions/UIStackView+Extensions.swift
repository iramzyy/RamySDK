//
//  UIStackView+Extensions.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/16/20\.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public extension UIStackView {
  convenience init(
      arrangedSubviews: [UIView],
      axis: NSLayoutConstraint.Axis,
      spacing: CGFloat = 0.0,
      alignment: UIStackView.Alignment = .fill,
      distribution: UIStackView.Distribution = .fill) {

      self.init(arrangedSubviews: arrangedSubviews)
      self.axis = axis
      self.spacing = spacing
      self.alignment = alignment
      self.distribution = distribution
  }
  
  convenience init(axis: NSLayoutConstraint.Axis,
                   alignment: UIStackView.Alignment = .fill,
                   distribution: UIStackView.Distribution = .fill,
                   spacing: CGFloat) {
    self.init()
    self.axis = axis
    self.alignment = alignment
    self.distribution = distribution
    self.spacing = spacing
    self.backgroundColor = .clear
  }
  
  func removeArrangedSubviews() {
    arrangedSubviews.forEach {
      $0.removeFromSuperview()
    }
  }

  func setArrangedSubview(_ views: [UIView]) {
    arrangedSubviews.forEach { $0.removeFromSuperview() }
    views.forEach { addArrangedSubview($0) }
  }

  func setArrangedSubview(_ views: UIView...) {
    setArrangedSubview(views)
  }

  func setLayoutMargin(_ edge: NSDirectionalEdgeInsets.Edge) {
    isLayoutMarginsRelativeArrangement = true
    directionalLayoutMargins = NSDirectionalEdgeInsets(edge)
  }
}
