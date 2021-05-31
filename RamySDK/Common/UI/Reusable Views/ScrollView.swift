//
//  ScrollView.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/13/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public final class ScrollView: UIScrollView, UIScrollViewDelegate {
  
  var shouldDisableTopBounce: Bool = false
  
  var scrollableContentView: UIView! {
    didSet {
      self.removeSubviews()
      self.addSubview(scrollableContentView)
      
      scrollableContentView.snp.makeConstraints { (make) in
        make.top.leading.trailing.centerX.equalToSuperview()
        make.centerY.equalToSuperview().priority(250)
        make.bottom.equalToSuperview().inset(Configurations.UI.Spacing.scrollViewBottomPadding).priority(250)
        make.width.equalToSuperview()
      }
    }
  }
  
  public override var contentLayoutGuide: UILayoutGuide {
    .init()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
}

extension ScrollView {
  func initialize() {
    self.clipsToBounds = false
    self.delegate = self
  }
}

public extension ScrollView {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard shouldDisableTopBounce else { return }
    if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
        scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
    }
  }
}
