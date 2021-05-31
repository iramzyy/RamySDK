//
//  TransactionEndpoint.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import Moya

public enum TransactionEndpoint {
  case getSpecificTransaction(Encodable)
  case getTransactionHistory(Encodable)
}

extension TransactionEndpoint: BaseEndpoint {
  public var path: String {
    switch self {
    case .getSpecificTransaction:
      return "v1/transaction"
    case .getTransactionHistory:
      return "v1/transaction/history"
    }
  }
  
  public var method: Method {
    switch self {
    case .getSpecificTransaction,
         .getTransactionHistory:
      return .get
    }
  }
  
  public var task: Task {
    var params = defaultParams
    switch self {
    case let .getTransactionHistory(task):
      params = params.merging(task.asDictionary()) { $1 }
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    case let .getSpecificTransaction(task):
      params = params.merging(task.asDictionary()) { $1 }
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
  }
}
