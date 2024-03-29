//
//  PagingCollectionViewLayout.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 5/05/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

open class PagingCollectionViewLayout: UICollectionViewFlowLayout {
  public var velocityThresholdPerPage: CGFloat = 2
  public var numberOfItemsPerPage: CGFloat = 1

  override open func targetContentOffset(
    forProposedContentOffset proposedContentOffset: CGPoint,
    withScrollingVelocity velocity: CGPoint
  ) -> CGPoint {
    guard let collectionView = collectionView else { return proposedContentOffset }

    let pageLength: CGFloat
    let approxPage: CGFloat
    let currentPage: CGFloat
    let speed: CGFloat

    if scrollDirection == .horizontal {
      pageLength = (itemSize.width + minimumLineSpacing) * numberOfItemsPerPage
      approxPage = collectionView.contentOffset.x / pageLength
      speed = velocity.x
    } else {
      pageLength = (itemSize.height + minimumLineSpacing) * numberOfItemsPerPage
      approxPage = collectionView.contentOffset.y / pageLength
      speed = velocity.y
    }

    if speed < 0 {
      currentPage = ceil(approxPage)
    } else if speed > 0 {
      currentPage = floor(approxPage)
    } else {
      currentPage = round(approxPage)
    }

    guard speed != 0 else {
      if scrollDirection == .horizontal {
        return CGPoint(x: currentPage * pageLength, y: 0)
      } else {
        return CGPoint(x: 0, y: currentPage * pageLength)
      }
    }

    var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)

    let increment = speed / velocityThresholdPerPage
    nextPage += (speed < 0) ? ceil(increment) : floor(increment)

    if scrollDirection == .horizontal {
      return CGPoint(x: nextPage * pageLength, y: 0)
    } else {
      return CGPoint(x: 0, y: nextPage * pageLength)
    }
  }
}
