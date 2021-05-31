//
//  RequestEndpoint.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/05/2021.
//

import Moya

public enum RequestEndpoint {
  case toOthers
  case toMe
  case request(uuid: String, amount: String, reason: String)
  case execute(action: String, requestID: String)
}

extension RequestEndpoint: BaseEndpoint {
  public var path: String {
    switch self {
    case .toOthers:
      return "/v1/request/from"
    case .toMe:
      return "/v1/request/to"
    case .request:
      return "/v1/request"
    case .execute:
      return "/v1/request"
    }
  }
  
  public var method: Method {
    switch self {
    case .toMe,
         .toOthers:
      return .get
    case .request:
      return .post
    case .execute:
      return .put
    }
  }
  
  public var task: Task {
    switch self {
    case .toMe,
         .toOthers:
      return .requestPlain
    case let .execute(action, requestID):
      return .requestParameters(
        parameters: [
          "request_uuid": requestID,
          "status": action
        ].merging(defaultParams, uniquingKeysWith: { $1 }),
        encoding: JSONEncoding.default)
    case let .request(uuid, amount, reason):
      return .requestParameters(
        parameters: [
          "user_identifier": uuid,
          "amount": amount,
          "reason": reason
        ].merging(defaultParams, uniquingKeysWith: { $1 }),
        encoding: JSONEncoding.default)
    }
  }
}
