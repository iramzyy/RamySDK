//
//  UIImageView+Kingfisher.swift
//  SQ10
//
//  Created by Ahmed Ramy on 28/10/2021.
//

import Kingfisher
import UIKit.UIImageView

public extension UIImageView {
    func load(from url: String) {
        if let imageUrl = URL(string: url) {
            load(from: imageUrl)
        }
    }

    func load(from url: URL, placeholder: UIImage? = nil) {
        kf.setImage(with: url,
                    placeholder: placeholder,
                    options: [.transition(.fade(0.25))])
    }
}
