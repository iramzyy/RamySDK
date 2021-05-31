//
//  WalletEndpoint.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 21/04/2021.
//

import Moya

public enum WalletEndpoint {
  case getMyWallet
  case transfer(Encodable)
  case updateTransfer(Encodable)
}

extension WalletEndpoint: BaseEndpoint {
  public var path: String {
    switch self {
    case .getMyWallet:
      return "v1/wallet"
    case .transfer:
      return "v1/wallet/transfer"
    case .updateTransfer:
      return "v1/wallet/transfer"
    }
  }
  
  public var method: Method {
    switch self {
    case .getMyWallet:
      return .get
    case .transfer:
      return .post
    case .updateTransfer:
      return .put
    }
  }
  
  public var task: Task {
    var params = defaultParams
    switch self {
    case .getMyWallet:
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    case .transfer(let task),
         .updateTransfer(let task):
      params = params.merging(task.asDictionary()) { $1 }
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
  }
}
