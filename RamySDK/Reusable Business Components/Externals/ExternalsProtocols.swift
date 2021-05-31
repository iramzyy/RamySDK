//
//  ExternalsProtocols.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

public protocol RouterProtocol: class {
  var presentedView: BaseViewController! { set get }
  func present(_ view: UIViewController, shouldBeFullScreen: Bool)
  func startActivityIndicator()
  func stopActivityIndicator()
  func dismiss(_ afterDismiss: VoidCallback?)
  func pop(animated: Bool)
  func popToRoot()
  func popTo(vc: UIViewController)
  func goBack()
  func push(_ view: UIViewController)
  func showSuccess(title: String, message: String)
  func showInfo(title: String, message: String)
  func showError(error: Error)
  func showError(message: String)
  func popup(viewModel: PopupViewModelProtocol)
  func alert(error: Error)
  func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)])
  func alertWithAction(title: String?, message: String?, alertStyle: UIAlertController.Style, tintColor: UIColor?, actions: [AlertAction])
}

public extension RouterProtocol {
  func dismiss(_ afterDismiss: VoidCallback? = nil) { }
}

public protocol NetworkProtocol: class {
  func call<T: Codable, U: BaseEndpoint>(api: U, model: T.Type, _ onFetch: @escaping (Result<T, Error>) -> Void)
}

