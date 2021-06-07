//
//  Metrics.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 02/06/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import UIKit

public enum Metrics {
  case radius
  
  func getMetric(for viewType: ViewType) -> CGFloat {
    switch (self, viewType) {
    case (.radius, .ratingForm):
      return 14
    case (.radius, .section):
      return 8
    }
  }
}

public extension Metrics {
  enum ViewType {
    case ratingForm
    case section
  }
}
