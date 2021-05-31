//
//  AuthEndpoint.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 02/04/2021.
//

import Moya

public enum AuthEndpoint {
  case register(Encodable)
  case login
}

extension AuthEndpoint: BaseEndpoint {
  public var path: String {
    switch self {
    case .register:
      return "/v1/user/"
    case .login:
      return "/v1/user"
    }
  }
  
  public var method: Method {
    switch self {
    case .register:
      return .post
    case .login:
      return .get
    }
  }
  
  public var task: Task {
    switch self {
    case let .register(task):
      var params = defaultParams
      params = params.merging(task.asDictionary()) { $1 }
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    case let .login:
      var params = defaultParams
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
  }
}
