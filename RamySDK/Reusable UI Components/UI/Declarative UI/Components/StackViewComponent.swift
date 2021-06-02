//
//  StackViewComponent.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import Carbon
import UIKit

public struct StackViewComponent: IdentifiableComponent {

  public var id: String { return "StackViewComponent" }

  private let views: [UIView]
  private let axis: NSLayoutConstraint.Axis
  private let spacing: CGFloat

  public init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, views: UIView...) {
    self.axis = axis
    self.spacing = spacing
    self.views = views
  }

  public func renderContent() -> UIStackView {
    let stackView = UIStackView(axis: axis, spacing: spacing)
    stackView.setArrangedSubview(views)
    return stackView
  }

  public func layout(content: UIStackView, in container: UIView) {
    container.addSubview(content)

    content.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.leading.equalTo(Configurations.UI.Spacing.p3)
      $0.trailing.equalTo(-Configurations.UI.Spacing.p3)
    }
  }

  public func shouldRender(next: StackViewComponent, in content: UIStackView) -> Bool {
    return false
  }

  public func render(in content: UIStackView) {
    content.setArrangedSubview(views)
  }
}

