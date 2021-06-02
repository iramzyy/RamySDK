//
//  ImageComponent.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon
import Kingfisher

public struct ImageComponent: IdentifiableComponent {

  public var id: String {
    return "ImageComponent"
  }

  private var url: String?
  private var image: UIImage?
  private var extraInset: UIEdgeInsets
  private var height: CGFloat
  private var usePaddings: Bool
  private var backgroundColor: UIColor?
  private var contentMode: UIView.ContentMode = .scaleAspectFit
  private var cornerRadius: CGFloat = 0

  public init(url: String? = nil, image: UIImage? = nil, height: CGFloat = 100, extraInset: UIEdgeInsets = .zero, usePaddings: Bool = false,
              backgroundColor: UIColor? = nil) {
    self.url = url
    self.image = image
    self.height = height
    self.extraInset = extraInset
    self.usePaddings = usePaddings
    self.backgroundColor = backgroundColor
  }

  public func shouldRender(next: ImageComponent, in content: UIImageView) -> Bool {
    return true
  }

  public func layout(content: UIImageView, in container: UIView) {
    container.addSubview(content)

    content.snp.makeConstraints { make in
      make.top.equalTo(extraInset.top)
      make.bottom.equalTo(extraInset.bottom)
      make.height.equalTo(height)

      make.leading.equalTo((usePaddings ? Configurations.UI.Spacing.p3 : 0) + extraInset.right)
      make.trailing.equalTo((usePaddings ? Configurations.UI.Spacing.p3 : 0) - extraInset.left)

    }
  }

  public func renderContent() -> UIImageView {
    let content = UIImageView()
    return content
  }

  public func render(in content: UIImageView) {
    content.contentMode = contentMode
    content.layer.cornerRadius = cornerRadius
    content.layer.masksToBounds = true
    if let url = url {
      content.set(visual: .url(url))
    } else {
      content.image = image
    }
  }
}
