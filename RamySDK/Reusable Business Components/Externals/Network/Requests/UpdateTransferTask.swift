//
//  UpdateTransferTask.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 21/04/2021.
//

import Foundation

public struct UpdateTransferTask: Encodable {
  let uuid: String
  let otp: String
  
  public enum CodingKeys: String, CodingKey {
    case uuid = "transaction_uuid"
    case otp
  }
}
