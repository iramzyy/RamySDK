//
//  ImageSliderViewController.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 17/05/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

final public class ImageSliderViewController: CollectionViewController<ImageSliderItemView> {
  
  lazy var pageControl = UIPageControl().then {
    $0.hidesForSinglePage = true
    $0.pageIndicatorTintColor = .white
    $0.currentPageIndicatorTintColor = R.color.primaryButtonBackgroundColor()
  }
  
  public init(shouldShowPageControl: Bool = true) {
    super.init(direction: .horizontal,
               itemSize: Dimensions.ImageSlider.imageSliderItemSize,
               itemSpacing: 0,
               insets: .zero)
    initialize(shouldShowPageControl)
    didScrollToIndex = {
      self.pageControl.currentPage = $0.item
    }
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  public override func reload() {
    super.reload()
    pageControl.numberOfPages = items.count
  }
  
  public func scrollTo(index: Int) {
    collectionContainer?.scrollTo(index: IndexPath(item: index, section: 0), position: .centeredHorizontally)
  }
}

private extension ImageSliderViewController {
  func initialize(_ shouldShowPageControl: Bool) {
    guard shouldShowPageControl else { return }
    self.view.addSubview(pageControl)
    pageControl.snp.makeConstraints { (make) in
      make.bottom.equalToSuperview().inset(20)
      make.centerX.equalToSuperview()
      make.leading.trailing.greaterThanOrEqualToSuperview()
      make.height.equalTo(20)
    }
  }
}

