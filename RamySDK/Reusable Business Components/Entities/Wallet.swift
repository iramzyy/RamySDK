//
//  Wallet.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 21/04/2021.
//

import Foundation

public final class Wallet: Cachable {
  public var uuid: String = ""
  public var currency: String?
  public var balance: String?
  public var isDefault: Bool?
  
  public enum CodingKeys: String, CodingKey {
    case uuid = "wallet_uuid"
    case currency = "wallet_currency"
    case balance = "wallet_balance"
    case isDefault = "default"
  }
  
  public init(uuid: String? = nil, currency: String? = nil, balance: String? = nil, isDefault: Bool? = nil) {
    self.uuid = uuid ?? ""
    self.currency = currency
    self.balance = balance
    self.isDefault = isDefault
  }
  
  public static func primaryKey() -> String? {
    "uuid"
  }
  
  public required init() { }
  
  static var mockedDefault: Wallet = .init(
    uuid: UUID().uuidString,
    currency: "EGP",
    balance: MoneyTransformer.format(amount: Double.random(in: (0.25...1500.00))),
    isDefault: true
  )
}
