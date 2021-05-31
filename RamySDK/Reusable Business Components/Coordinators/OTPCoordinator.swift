//
//  OTPCoordinator.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 15/04/2021.
//

import UIKit.UIViewController

public enum OTPCoordinator {
  public static func startFlow(phoneNumber: String, onOTPCompletion: @escaping Callback<OTPVerificationStatus>) -> UIViewController {
    let vc = OTPViewController()
    let vm = OTPViewModel(router: vc.router, interactor: OTPInteractor(phoneNumber: phoneNumber))
    vm.onOTPCompletion = onOTPCompletion
    vc.bind(to: vm)
    
    return vc
  }
}
