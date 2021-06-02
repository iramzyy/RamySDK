//
//  PagingCollectionView.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 5/08/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public extension UICollectionView {

  static func standard(direction: UICollectionView.ScrollDirection,
                 itemSize: CGSize,
                 itemSpacing: CGFloat,
                 insets: UIEdgeInsets) -> UICollectionView {
    let layout = PagingCollectionViewLayout()
    layout.scrollDirection = direction
    layout.sectionInset = insets
    layout.itemSize = itemSize
    layout.minimumLineSpacing = itemSpacing

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.decelerationRate = .fast
    return collectionView
  }
}
