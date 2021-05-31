//
//  LoadableViewController.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit.UIViewController

protocol LoadableViewController: class {
  func startLoading()
  func stopLoading()
}
