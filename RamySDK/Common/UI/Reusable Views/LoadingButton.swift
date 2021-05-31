//
//  LoadingButton.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import UIKit

open class LoadingButton: Button {
  lazy var activityIndicator: UIActivityIndicatorView = {
    
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.hidesWhenStopped = true
    self.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
    return activityIndicator
  }()
  
  var didConstraintWidth: Bool = false
  
  public func startLoading() {
    hideUI()
    placeActivityIndicator()
    layoutSubviews()
  }
  
  public func stopLoading() {
    showUI()
    removeActivityIndicator()
    layoutSubviews()
  }
  
  private func showUI() {
    updateType()
  }
  
  private func hideUI() {
    constraintWidthIfNeeded()
    setText("", buttonStyle: DisabledButtonStyle())
    setIcon(UIImage(), tintColor: nil, farEdge: false)
  }
  
  private func constraintWidthIfNeeded() {
    if !didConstraintWidth {
      snp.makeConstraints { (make) in
        make.width.equalTo(self.frame.size.width)
      }
      didConstraintWidth = true
    }
  }
  
  private func placeActivityIndicator() {
    activityIndicator.startAnimating()
  }
  
  private func removeActivityIndicator() {
    activityIndicator.stopAnimating()
  }
}
