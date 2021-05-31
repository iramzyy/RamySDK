//
//  RegisterTask.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 02/04/2021.
//

import Foundation

public struct RegisterTask: Encodable {
  let fullName: String
  let nationalID: String
  let email: String
  let phoneNumber: String
}
