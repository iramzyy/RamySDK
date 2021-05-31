//
//  Router.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit
import PopupDialog
import Kingfisher
import PKHUD
import SwiftMessages

public typealias AlertAction = (title: String, style: UIAlertAction.Style, action: () -> Void)

private struct SystemMessage {
  let view: MessageView
  let config: SwiftMessages.Config
  
  static func statusBarMessage(title: String, body: String, theme: Theme) -> SystemMessage {
    let view = MessageView.viewFromNib(layout: .cardView).then {
      $0.configureTheme(theme)
      $0.configureContent(title: title, body: body)
      $0.configureNoDropShadow()
      $0.configureIcon(withSize: .zero)
      $0.button?.isHidden = true
    }
    
    var config = SwiftMessages.Config()
    config.presentationContext = .window(windowLevel: .alert)
    config.presentationStyle = .top
    config.duration = .seconds(seconds: calculateSuitableTimeForReadingInfo(title: title, body: body))
    config.prefersStatusBarHidden = true
    config.interactiveHide = true
    
    return .init(view: view, config: config)
  }
  
  private static func calculateSuitableTimeForReadingInfo(title: String, body: String) -> Double {
    let averageWordPerSecond = 0.303
    let minimumShowingTime = 2.5
    return max(minimumShowingTime, (Double(title.wordCount() + body.wordCount()) * averageWordPerSecond))
  }
}

public final class Router: RouterProtocol {
  public weak var presentedView: BaseViewController!
  
  public func present(_ view: UIViewController, shouldBeFullScreen: Bool) {
    if shouldBeFullScreen {
      view.modalPresentationStyle = .fullScreen
    }
    presentedView?.present(view, animated: true, completion: nil)
  }
  
  public func startActivityIndicator() {
    presentedView?.startLoading()
  }
  
  public func stopActivityIndicator() {
    presentedView?.stopLoading()
  }
  
  public func dismiss(_ afterDismiss: VoidCallback?) {
    presentedView?.dismiss(animated: true, completion: afterDismiss)
  }
  
  public func pop() {
    
  }
  
  public func pop(animated: Bool) {
    _ = presentedView?.navigationController?.popViewController(animated: animated)
  }
  
  public func popToRoot() {
    _ = presentedView?.navigationController?.popToRootViewController(animated: true)
  }
  
  public func popTo(vc: UIViewController) {
    _ = presentedView?.navigationController?.popToViewController(vc, animated: true)
  }
  
  public func push(_ view: UIViewController) {
    presentedView?
      .navigationController?
      .pushViewController(view, animated: true)
  }
  
  public func alert(error: Error) {
    alert(title: "Error", message: error.localizedDescription, actions: [("Ok", .default)])
  }
  
  public func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    actions
      .map {
        UIAlertAction(title: $0.title, style: $0.style, handler: nil)
    }
    .forEach {
      alert.addAction($0)
    }
    presentedView?.present(alert, animated: true)
  }
  
  
  public func alertWithAction(title: String?,
                       message: String?,
                       alertStyle: UIAlertController.Style,
                       tintColor: UIColor?,
                       actions: [AlertAction]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
    actions.map { action in
      UIAlertAction(title: action.title, style: action.style, handler: { (_) in
        action.action()
      })
    }.forEach {
      alert.addAction($0)
    }
    
    if let tintColor = tintColor {
      alert.view.tintColor = tintColor
    }
    
    presentedView?.present(alert, animated: true)
  }
  
  public func showSuccess(title: String, message: String) {
    SwiftMessages.show(message: .statusBarMessage(title: title, body: message, theme: .success))
  }
  
  public func showInfo(title: String, message: String) {
    SwiftMessages.show(message: .statusBarMessage(title: title, body: message, theme: .info))
  }
  
  public func showError(error: Error) {
    SwiftMessages.show(message: .statusBarMessage(title: "Error".localized(), body: error.localizedDescription, theme: .error))
  }
  
  public func showError(message: String) {
    SwiftMessages.show(message: .statusBarMessage(title: "Error".localized(), body: message, theme: .error))
  }
  
  public func goBack() {
    if presentedView.navigationController != nil {
      pop(animated: true)
    } else {
      dismiss(nil)
    }
  }
  
  public func popup(viewModel: PopupViewModelProtocol) {
    switch viewModel.image {
    case .image(let image):
      showPopup(title: viewModel.title, message: viewModel.description, image: image)
    case .url(let url):
      guard let url = URL(string: url ?? "") else {
        showPopup(title: viewModel.title, message: viewModel.description)
        return
      }
      KingfisherManager.shared.retrieveImage(with: url) { [weak self] (results) in
        guard let self = self else { return }
        switch results {
        case .success(let value):
          self.showPopup(title: viewModel.title, message: viewModel.description, image: value.image)
        case .failure:
          self.showPopup(title: viewModel.title, message: viewModel.description)
        }
      }
    }
  }
  
  private func showPopup(title: String, message: String, image: UIImage? = nil) {
    let popup = PopupDialog(title: title, message: message, image: image)
    self.presentedView.present(popup, animated: true, completion: nil)
  }
}

private extension SwiftMessages {
  static func show(message: SystemMessage) {
    Self.show(config: message.config, view: message.view)
  }
}
