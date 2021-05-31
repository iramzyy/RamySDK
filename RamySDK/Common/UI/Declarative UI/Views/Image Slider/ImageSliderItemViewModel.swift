//
//  ImageSliderItemViewModel.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 17/05/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public protocol ImageSliderItemViewModelProtocol {
  var image: VisualContent { get }
}

public struct ImageSliderItemViewModel: ImageSliderItemViewModelProtocol {
  public let image: VisualContent

  public init(image: VisualContent) {
    self.image = image
  }
}
