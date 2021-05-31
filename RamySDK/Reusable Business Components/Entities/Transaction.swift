//
//  Transaction.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 21/04/2021.
//

import Foundation

public final class Transaction: Cachable {
  public var uuid: String = ""
  public var timestamp: String?
  public var fromWallet: String?
  public var toWallet: String?
  public var currency: String?
  public var amount: String?
  
  enum CodingKeys: String, CodingKey {
    case uuid = "transaction_uuid"
    case timestamp = "transaction_timestamp"
    case fromWallet = "from_wallet"
    case toWallet = "to_wallet"
    case currency = "currency"
    case amount = "amount"
  }
  
  public init(transactionUUID: String?, transactionTimestamp: String?, fromWallet: String?, toWallet: String?, currency: String?, amount: String?) {
    self.uuid = transactionUUID ?? ""
    self.timestamp = transactionTimestamp
    self.fromWallet = fromWallet
    self.toWallet = toWallet
    self.currency = currency
    self.amount = amount
  }
  
  public static func primaryKey() -> String? {
    "uuid"
  }
  
  public required init() { }
  
  public static let mockedROI: [Transaction] = [
    .init(
      transactionUUID: UUID().uuidString,
      transactionTimestamp: Date().adding(.hour, value: Int.random(in: 1...5)).dateString(),
      fromWallet: UUID().uuidString,
      toWallet: UUID().uuidString,
      currency: "EGP",
      amount: MoneyTransformer.format(amount: Double.random(in: 1.5...125.95))
    ),
    .init(
      transactionUUID: UUID().uuidString,
      transactionTimestamp: Date().adding(.hour, value: Int.random(in: 1...5)).dateString(),
      fromWallet: UUID().uuidString,
      toWallet: UUID().uuidString,
      currency: "EGP",
      amount: MoneyTransformer.format(amount: Double.random(in: 1.5...125.95))
    ),
    .init(
      transactionUUID: UUID().uuidString,
      transactionTimestamp: Date().adding(.hour, value: Int.random(in: 1...5)).dateString(),
      fromWallet: UUID().uuidString,
      toWallet: UUID().uuidString,
      currency: "EGP",
      amount: MoneyTransformer.format(amount: Double.random(in: 1.5...125.95))
    ),
    .init(
      transactionUUID: UUID().uuidString,
      transactionTimestamp: Date().adding(.hour, value: Int.random(in: 1...5)).dateString(),
      fromWallet: UUID().uuidString,
      toWallet: UUID().uuidString,
      currency: "EGP",
      amount: MoneyTransformer.format(amount: Double.random(in: 1.5...125.95))
    ),
    .init(
      transactionUUID: UUID().uuidString,
      transactionTimestamp: Date().adding(.hour, value: Int.random(in: 1...5)).dateString(),
      fromWallet: UUID().uuidString,
      toWallet: UUID().uuidString,
      currency: "EGP",
      amount: MoneyTransformer.format(amount: Double.random(in: 1.5...125.95))
    ),
  ]
}
