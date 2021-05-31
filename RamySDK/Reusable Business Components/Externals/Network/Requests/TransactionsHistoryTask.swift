//
//  TransactionsHistoryTask.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import Foundation

public struct TransactionHistoryTask: Codable {
  let uuid: String
  
  enum CodingKeys: String, CodingKey {
    case uuid = "wallet_uuid"
  }
}
