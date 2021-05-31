//
//  TransactionService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import Foundation

public protocol TransactionServiceProtocol: Service {
  func checkTransactionType(_ transaction: Transaction) -> TransactionType?
}

public final class MockedTransactionService: TransactionServiceProtocol {
  
  var shouldBeSent: Bool = true
  
  public func checkTransactionType(_ transaction: Transaction) -> TransactionType? {
    return shouldBeSent ? .sent : .received
  }
}

public final class TransactionService: TransactionServiceProtocol {
  
  private let walletService: WalletServiceProtocol
  
  public init(walletService: WalletServiceProtocol) {
    self.walletService = walletService
  }
  
  public func checkTransactionType(_ transaction: Transaction) -> TransactionType? {
    guard let defaultWalletUUID = walletService.defaultWallet.value?.uuid else { return nil }
    if transaction.fromWallet ?? "" == defaultWalletUUID {
      return .sent
    } else if transaction.toWallet ?? "" == defaultWalletUUID {
      return .received
    } else {
      LoggersManager.error(
        "Couldn't Determine transaction's type because neither toWallet nor fromWallet matches the default wallet's uuid"
          .tagWith(.internal)
      )
      return nil
    }
  }
}
