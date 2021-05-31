//
//  PhoneNumberKitHelper.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 30/03/2021.
//

import Foundation
import PhoneNumberKit

public final class PhoneNumberKitHelper {
  
  public static let PhoneNumberKitInstance: PhoneNumberKit = PhoneNumberKit()
  
  static func validate(string: String) -> Bool {
    do  {
      let _ = try PhoneNumberKitInstance.parse(string)
      return true
    } catch {
      return false
    }
  }
  
  static func regionID(of phone: String) -> String? {
    return try? PhoneNumberKitInstance.parse(phone).regionID
  }
  
}
