//
//  CollectionView.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 6/12/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

open class CollectionView<View: Configurable>: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  // MARK: - Public

  public var items: [View.ViewModelType] = []
  
  public let collectionView: UICollectionView
  public var didScrollToIndex: ((IndexPath) -> Void)?

  // MARK: - Private

  private let itemSize: CGSize
  private let itemSpacing: CGFloat
  private let insets: UIEdgeInsets
  private let minimumLineSpacing: CGFloat
  private let didSelect: ((Int, View.ViewModelType) -> ())?
  private let willDisplayHandler: ((Int, View.ViewModelType) -> ())?
  private let configureView: ((Int, View, View.ViewModelType) -> Void)?

  public init(
    direction: UICollectionView.ScrollDirection,
    itemSize: CGSize,
    itemSpacing: CGFloat,
    insets: UIEdgeInsets,
    minimumLineSpacing: CGFloat = 10,
    didSelect: ((Int, View.ViewModelType) -> ())? = nil,
    willDisplayHandler: ((Int, View.ViewModelType) -> ())? = nil,
    configureView: ((Int, View, View.ViewModelType) -> Void)? = nil,
    estimatedSize: CGSize? = nil,
    topSpaceIsActive: Bool = false) {

    self.collectionView = UICollectionView.standard(direction: direction,
                                                    itemSize: itemSize,
                                                    itemSpacing: itemSpacing,
                                                    insets: insets)
    collectionView.register(ContainerCollectionViewCell<View>.self,
                            forCellWithReuseIdentifier: String(describing: ContainerCollectionViewCell<View>.self))

    self.itemSize = itemSize
    self.itemSpacing = itemSpacing
    self.insets = insets
    self.didSelect = didSelect
    self.willDisplayHandler = willDisplayHandler
    self.configureView = configureView
    self.minimumLineSpacing = minimumLineSpacing
    if let estimatedSize = estimatedSize {
      (self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = estimatedSize
    }
    if topSpaceIsActive,
       let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
    }
    super.init(frame: CGRect.zero)

    collectionView.dataSource = self
    collectionView.delegate = self
    
    setupViews()
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func reload() {
    collectionView.reloadData()
  }
  
  public func scrollTo(index: IndexPath, position: UICollectionView.ScrollPosition, animated: Bool = true) {
    collectionView.scrollToItem(at: index, at: position, animated: animated)
  }

  // MARK: - CollectionView Data Source

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(type: ContainerCollectionViewCell<View>
        .self,
                           forIndexPath: indexPath)

    if let item = self.item(at: indexPath.row) {
      cell.configure(with: item)
      configureView?(indexPath.row, cell.view, item)
    }

    return cell
  }

  // MARK: - CollectionView Delegate

  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let item = self.item(at: indexPath.row) {
      self.didSelect?(indexPath.row, item)
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if let item = self.item(at: indexPath.row) {
      self.willDisplayHandler?(indexPath.row, item)
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return itemSize
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return minimumLineSpacing
  }
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
        didScrollToIndex?(visibleIndexPath)
    }
  }
  
  private func setupViews() {
    addSubview(collectionView)

    setupConstraints()
  }
}

private extension CollectionView {
 
  func setupConstraints() {
    collectionView.fillSuperview()
  }

  func item(at index: Int) -> View.ViewModelType? {
    guard index >= 0, index < items.count else { return nil }

    return items[index]
  }
}
