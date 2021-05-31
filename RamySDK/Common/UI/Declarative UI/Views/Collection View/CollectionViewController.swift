//
//  HorizontalCollectionViewController.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 5/05/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

open class CollectionViewController<View: Configurable>: UIViewController {
  // MARK: - Public

  public var collectionContainer: CollectionView<View>?
  public var didScrollToIndex: ((IndexPath) -> Void)?

  private(set) var items: [View.ViewModelType] {
    get {
      return collectionContainer?.items ?? []
    }
    set {
      collectionContainer?.items = newValue
    }
  }
  
  public init(
    direction: UICollectionView.ScrollDirection,
    itemSize: CGSize,
    itemSpacing: CGFloat,
    insets: UIEdgeInsets,
    didSelect: ((Int, View.ViewModelType) -> ())? = nil,
    willDisplayHandler: ((Int, View.ViewModelType) -> ())? = nil,
    configureView: ((Int, View, View.ViewModelType) -> Void)? = nil,
    estimatedSize: CGSize? = nil,
    topSpaceIsActive: Bool = false) {
    
    super.init(nibName: nil, bundle: nil)
    
    collectionContainer = CollectionView(
      direction: direction,
      itemSize: itemSize,
      itemSpacing: itemSpacing,
      insets: insets,
      didSelect: didSelect,
      willDisplayHandler: willDisplayHandler,
      configureView: configureView,
      estimatedSize: estimatedSize,
      topSpaceIsActive: topSpaceIsActive
    )
    
    guard let collectionView = collectionContainer else { return }
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
    
    collectionContainer?.didScrollToIndex = { [weak self] index in
      self?.didScrollToIndex?(index)
    }
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func setItems(items: [View.ViewModelType]) {
    self.items = items
  }
  
  public func setItemsAndReloadData(items: [View.ViewModelType]) {
    self.items = items
    self.reload()
  }
  
  public func reload() {
    collectionContainer?.reload()
  }
  
  public func scrollTo(index: IndexPath, position: UICollectionView.ScrollPosition, animated: Bool = true) {
    collectionContainer?.scrollTo(index: index, position: position)
  }
}
