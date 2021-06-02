//
//  NavigationLeadingTextView.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

final class NavigationLabelView: UIView, ConfigurableProtocol {
  let titleLabel = UILabel().then {
    $0.font = FontStyles.body.font
    $0.textColor = R.color.primaryDefault()!
  }
  
  public func configure(with viewModel: NavigationBarViewModelProtocol) {
    switch viewModel.layout {
    case .leading:
      titleLabel.textAlignment = UILocalization.shared.textAlignment
    case .trailing:
      titleLabel.textAlignment = UILocalization.shared.reversedTextAlignment
    case .center:
      titleLabel.textAlignment = .center
    }
    
    titleLabel.text = viewModel.title
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
}

// MARK: - Private
private extension NavigationLabelView {
  func initialize() {
    setupViews()
    setupConstraints()
  }

  func setupViews() {
    addSubview(titleLabel)
  }

  func setupConstraints() {
    titleLabel.fillToSuperview()
  }
}
