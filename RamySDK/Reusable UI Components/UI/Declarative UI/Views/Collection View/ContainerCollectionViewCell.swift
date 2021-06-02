//
//  ContainerCollectionViewCell.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 5/05/2020.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

final public class ContainerCollectionViewCell<View: Configurable>: UICollectionViewCell {
  
  let view = View()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
  
  public func configure(with viewModel: View.ViewModelType) {
    view.configure(with: viewModel)
  }
}

private extension ContainerCollectionViewCell {
  func initialize() {
    contentView.addSubview(view)
    view.fillSuperview()
  }
}
