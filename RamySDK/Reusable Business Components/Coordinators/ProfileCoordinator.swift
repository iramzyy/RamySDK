//
//  ProfileCoordinator.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 05/04/2021.
//

import UIKit

public enum ProfileCoordinator {
  public static func startFlow() -> UIViewController {
    let vc = ProfileViewController()
    let vm = ProfileViewModel(router: vc.router)
    vc.bind(to: vm)
    return vc
  }
}
