//
//  ImageSliderItemView.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 17/05/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public class ImageSliderItemView: ImageView, Configurable {
  public override init() {
    super.init()
    rounded = .none
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with viewModel: ImageSliderItemViewModelProtocol) {
    set(visual: viewModel.image)
  }
}
