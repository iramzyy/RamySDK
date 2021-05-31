//
//  MainCoordinator.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 30/03/2021.
//

import UIKit.UIViewController

public enum MainCoordinator {
  public static func startFlow() -> UIViewController {
    return MainTabBarController()
  }
}
