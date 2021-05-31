//
//  TransferToWalletTask.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 21/04/2021.
//

import Foundation

public struct TransferToWalletTask: Encodable {
  public let uuid: String
  public let userUUID: String
  public let amount: String
  
  public enum CodingKeys: String, CodingKey {
    case uuid = "transaction_uuid"
    case userUUID = "user_identifier"
    case amount
  }
}
