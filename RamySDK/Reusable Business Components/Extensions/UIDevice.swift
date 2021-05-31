//
//  UIDevice.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 03/04/2021.
//

import UIKit

public extension UIDevice {
   class var isPhone: Bool {
       return UIDevice.current.userInterfaceIdiom == .phone
   }

   class var isPad: Bool {
       return UIDevice.current.userInterfaceIdiom == .pad
   }

   class var isTV: Bool {
       return UIDevice.current.userInterfaceIdiom == .tv
   }

   class var isCarPlay: Bool {
       return UIDevice.current.userInterfaceIdiom == .carPlay
   }
}
