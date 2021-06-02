//
//  ImageSliderComponent.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import Carbon

public typealias ImageSliderScrollHandler = ((Int, ImageSliderItemViewModelProtocol) -> Void)

public struct ImageSliderComponent: IdentifiableComponent {
  
  private let items: [ImageSliderItemViewModelProtocol]
  private let height: CGFloat
  private let shouldShowPageControl: Bool
  private var scrollHandler: ImageSliderScrollHandler?
  private var currentSlide: Int
  init(
    items: [ImageSliderItemViewModelProtocol],
    height: CGFloat = Dimensions.ImageSlider.imageSliderItemSize.height,
    shouldShowPageControl: Bool = false,
    currentSlide: Int,
    scrollHandler: @escaping ImageSliderScrollHandler
  ) {
    self.items = items
    self.height = height
    self.shouldShowPageControl = shouldShowPageControl
    self.scrollHandler = scrollHandler
    self.currentSlide = currentSlide
  }

  public func renderContent() -> ImageSliderViewController {
    ImageSliderViewController(shouldShowPageControl: self.shouldShowPageControl)
  }

  public func render(in content: ImageSliderViewController) {
    content.setItemsAndReloadData(items: items)
    content.didScrollToIndex = { indexPath in
      let index = indexPath.row
      self.scrollHandler?(index, self.items[index])
    }
    
    content.scrollTo(index: 2)
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    CGSize(width: bounds.width, height: height)
  }
}
