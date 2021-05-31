//
//  ListableViewController.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/16/20\.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon
import SnapKit
import UIKit

open class ListableViewController: BaseViewController {
  
  open var tableViewStyle: UITableView.Style {
    return .grouped
  }
  
  public var tableView: ContentSizedTableView!
  
  public let renderer = Renderer(
    adapter: UITableViewCustomAdapter(),
    updater: UITableViewUpdater()
  )
  
  public let rendererWithoutAnimation = Renderer(
    adapter: UITableViewCustomAdapter(),
    updater: UITableViewReloadDataUpdater()
  )
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    
    enableKeyboardOperations()
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    toggleNavigationBar(show: true)
  }
  
  open func scrollToTop() {
    tableView.setContentOffset(CGPoint.zero, animated: true)
  }
  
  public func render(sections: [Section], animated: Bool = true) {
    configureRender(animated: animated)
    
    if animated {
      renderer.render(sections)
    } else {
      rendererWithoutAnimation.render(sections)
    }
  }
  
  // MARK: - Keyboard Events
  
  private func enableKeyboardOperations() {
    // Enable keyboard dismiss mode to let user dismiss while scrolling.
    tableView.keyboardDismissMode = .interactive
    // Enable keyboard events to add inset at the bottom while the keyboard is open.
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  }
}

// MARK: - Private

private extension ListableViewController {
  func initialize() {
    setupViews()
    setupConstraints()
    configureRender()
  }
  
  func configureRender(animated: Bool = true) {
    if animated {
      renderer.adapter.parentViewController = self
      renderer.target = tableView
    } else {
      rendererWithoutAnimation.adapter.parentViewController = self
      rendererWithoutAnimation.target = tableView
    }
  }
  
  func setupViews() {
    setupTableView()
    tableView.contentInsetAdjustmentBehavior = .never
  }
  
  func setupConstraints() {
    
  }
  
  func setupTableView() {
    tableView = ContentSizedTableView(frame: .zero, style: tableViewStyle).then {
      $0.setContentCompressionResistancePriority(.required, for: .vertical)
      $0.setContentHuggingPriority(.defaultLow, for: .vertical)
      $0.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude))
      $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude))
      $0.separatorStyle = .none
      $0.backgroundColor = R.color.primaryBackgroundColor()
      $0.contentInset = .zero
      $0.estimatedRowHeight = 250
    }
  }
  
}

public final class ContentSizedTableView: UITableView {
  public override var contentSize: CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  public override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }
}
