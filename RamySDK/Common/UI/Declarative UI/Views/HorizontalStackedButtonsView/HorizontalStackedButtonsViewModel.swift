//
//  HorizontalStackedButtonsViewModel.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import UIKit

public protocol HorizontalStackedButtonViewModelProtocol {
  var icon: UIImage { get }
  var title: String { get }
  var isLoading: Bool { get }
  var action: VoidCallback { get }
}

public struct HorizontalStackedButtonViewModel: HorizontalStackedButtonViewModelProtocol {
  public let icon: UIImage
  public let title: String
  public let isLoading: Bool
  public let action: VoidCallback
  
  public init(
    icon: UIImage,
    title: String,
    isLoading: Bool = false,
    analyticsName: String,
    action: @escaping VoidCallback
  ) {
    self.icon = icon
    self.title = title
    self.isLoading = isLoading
    self.action = action
  }
}


