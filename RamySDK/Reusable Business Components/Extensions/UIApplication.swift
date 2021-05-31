//
//  UIApplication.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 03/04/2021.
//

import UIKit

public extension UIApplication {
  public class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?
    .rootViewController) -> BaseViewController? {
    if let nav = viewController as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    if let tab = viewController as? UITabBarController {
      if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    if let presented = viewController?.presentedViewController {
      return topViewController(presented)
    }

    return viewController as? BaseViewController
  }
}
