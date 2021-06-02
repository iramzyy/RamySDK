//
//  UIImageView+Extensions.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
  
  public func load(from url: String) {
    if let imageUrl = URL(string: url) {
      load(from: imageUrl)
    }
  }

  public func load(from url: URL) {
    kf.setImage(with: url,
    placeholder: nil,
    options: [.transition(.fade(0.1))])
  }

  public func cancelDownload() {
    kf.cancelDownloadTask()
  }

  public func set(visual content: VisualContent?, isHiddenable: Bool = false, tintColor: UIColor? = nil) {
    guard let content = content else {
      self.image = nil
      self.isHidden = isHiddenable
      return
    }
    switch content {
    case .image(let image):
      let desiredImage = tintColor != nil ? image?.withTintColor(tintColor!) : image
      self.image = desiredImage
      if image == nil {
        self.isHidden = isHiddenable
      }
    case .url(let url):
      self.load(from: url ?? "")
    }
  }
}
