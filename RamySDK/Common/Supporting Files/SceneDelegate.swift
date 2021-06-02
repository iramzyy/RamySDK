//
//  SceneDelegate.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/15/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit
import RxSwift

class SceneDelegate: ScenePluggableDelegate {
  static let restartSubject = PublishSubject<Void>()
  private let disposeBag = DisposeBag()
  
  override init() {
    super.init()
    Self.restartSubject.subscribe(onNext: {
      self.restart()
    }).disposed(by: disposeBag)
  }
}

extension SceneDelegate {
  override func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    guard let scene = scene as? UIWindowScene else { return }
    // Build and assign main window
    window = UIWindow(windowScene: scene)
    defer { window?.makeKeyAndVisible() }
    guard !isUnitTesting else { return }
//    set(rootViewTo: AppCoordinator.startFlow())
    
  }
}

// MARK: - Helpers

private extension SceneDelegate {
  
  /// Assign root view to window. Adds any environment objects if needed.
  func set<T: UIViewController>(rootViewTo view: T) {
    window?.rootViewController = view
  }
  
  var isUnitTesting: Bool {
    return ProcessInfo.processInfo.arguments.contains("-UNITTEST")
  }
  
  func restart() {
    defer { window?.makeKeyAndVisible() }
//    window?.switchRootViewController(to: AppCoordinator.startFlow(), animated: true, duration: 0.6, options: .transitionCurlUp, {})
  }
}
