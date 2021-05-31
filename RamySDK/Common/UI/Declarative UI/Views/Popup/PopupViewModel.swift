//
//  PopupViewModel.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/22/20\.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public protocol PopupViewModelProtocol {
  var image: VisualContent { get set }
  var title: String { get set }
  var description: String { get set }
}

public struct PopupViewModel: PopupViewModelProtocol {
  public var image: VisualContent
  public var title: String
  public var description: String
  
  public init(image: VisualContent, title: String, description: String) {
    self.image = image
    self.title = title
    self.description = description
  }
}
