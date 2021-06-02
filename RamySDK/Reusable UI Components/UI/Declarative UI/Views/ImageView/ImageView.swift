//
//  ImageView.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import UIKit

open class ImageView: UIView {
  public enum Rounded {
    case none
    case circle
    case custom(value: CGFloat)
  }

  public var rounded: Rounded = .none {
    didSet {
      updateUI()
    }
  }

  public var url: String? {
    didSet {
      if let url = url {
        imageView.cancelDownload()
        imageView.load(from: url)
      } else {
        imageView.image = nil
        cancelDownload()
      }
    }
  }
  
  public var overlay: UIColor? {
    didSet {
      overlayView.backgroundColor = overlay
    }
  }

  public var image: UIImage? {
    set {
      imageView.image = newValue
    }
    get {
      imageView.image
    }
  }
  
  open override var intrinsicContentSize: CGSize {
    return imageView.intrinsicContentSize
  }

  public override var contentMode: ContentMode {
    get {
      imageView.contentMode
    }
    set {
      imageView.contentMode = newValue
    }
  }

  public override var tintColor: UIColor! {
    get {
      imageView.tintColor
    }
    set {
      imageView.tintColor = newValue
    }
  }

  private let containerView: UIView = UIView().then {
    $0.backgroundColor = .clear
    $0.clipsToBounds = true
  }

  private let imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.layer.masksToBounds = true
  }
  
  private let overlayView: UIView = UIView()

  public init() {
    super.init(frame: .zero)
    initialize()
  }

  public init(image: UIImage, rounded: Rounded) {
    self.rounded = rounded
    imageView.image = image
    super.init(frame: .zero)
    initialize()
  }

  public init(url: String, rounded: Rounded) {
    self.rounded = rounded
    self.url = url
    super.init(frame: .zero)
    initialize()
  }

  public init(url: URL, rounded: Rounded) {
    self.rounded = rounded
    imageView.load(from: url)
    super.init(frame: .zero)
    initialize()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    updateUI()
  }

  public func set(visual: VisualContent?) {
    imageView.set(visual: visual)
  }

  public func cancelDownload() {
    imageView.cancelDownload()
  }
  
  public func setBackgroundColor(_ color: UIColor) {
    containerView.backgroundColor = color
  }
  
  public func setBorderWidth(_ width: CGFloat) {
    containerView.layer.borderWidth = width
  }
  
  public func setBorderColor(_ color: UIColor) {
    containerView.layer.borderColor = color.cgColor
  }
  
}

// MARK: - Private

private extension ImageView {
  func initialize() {
    setupViews()
  }

  func setupViews() {
    contentMode = .scaleAspectFill
    containerView.addSubview(imageView)
    containerView.addSubview(overlayView)
    addSubview(containerView)

    setupConstaints()
  }

  func setupConstaints() {
    containerView.translatesAutoresizingMaskIntoConstraints = true
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    imageView.translatesAutoresizingMaskIntoConstraints = true
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    overlayView.fillSuperview()
  }

  func updateUI() {
    switch rounded {
    case .none:
      containerView.layer.cornerRadius = 0
    case .circle:
      containerView.layer.cornerRadius = bounds.size.width / 2
    case let .custom(value):
      containerView.layer.cornerRadius = value
    }
  }
}
