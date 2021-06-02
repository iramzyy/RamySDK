//
//  HorizontalStackedButtonsView.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import UIKit

open class HorizontalStackedButtonsView: UIView, Configurable {
  internal let hStack = UIStackView(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 0)
  
  internal let borderView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = R.color.secondaryDefault()!.cgColor
  }
  
  public func configure(with viewModel: [HorizontalStackedButtonViewModelProtocol]) {
    let views: [UIView] = viewModel.map { model in
      model.isLoading ? makeLoadingStateButton(with: model) : makeButton(with: model)
    }
    hStack.setArrangedSubview(views)
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

private extension HorizontalStackedButtonsView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(borderView)
    borderView.addSubview(hStack)
  }
  
  func setupConstraints() {
    borderView.fillSuperview()
    self.hStack.snp.makeConstraints { (make) in
      make.leading.trailing.top.bottom.equalToSuperview()
    }
  }
  
  func makeButton(with model: HorizontalStackedButtonViewModelProtocol) -> Button {
    return Button(type: .system).then { (button: Button) in
      button.type = .textWithLeadingIcon(model.title, icon: model.icon, style: PrimaryButtonStyle())
      button.setControlEvent(.touchUpInside) {
        model.action()
      }
      button.layer.cornerRadius = 0
      button.addBorder(.left, color: R.color.monochromaticLine()!, thickness: 1)
    }
  }
  
  func makeLoadingStateButton(with model: HorizontalStackedButtonViewModelProtocol) -> UIView {
    let activityIndicator = UIActivityIndicatorView().then {
      $0.startAnimating()
    }
    let button = Button(type: .system).then { (button: Button) in
      button.type = .text(model.title, style: PrimaryButtonStyle())
    }
    let hStack = UIStackView(axis: .horizontal, alignment: .center, distribution: .equalCentering, spacing: 2).then {
      $0.isUserInteractionEnabled = false
      $0.setArrangedSubview([UIView(), activityIndicator, button, UIView()])
    }
    return hStack
  }
  
}
