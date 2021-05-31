//
//  UserEndpoint.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import Moya

public enum UserEndpoint {
  case getMyProfile
  case updateMyProfile(Encodable)
}

extension UserEndpoint: BaseEndpoint {
  public var path: String {
    switch self {
    case .getMyProfile,
         .updateMyProfile:
      return "v1/user"
    }
  }
  
  public var method: Method {
    switch self {
    case .getMyProfile:
      return .get
    case .updateMyProfile:
      return .put
    }
  }
  
  public var task: Task {
    var params = defaultParams
    switch self {
    case .getMyProfile:
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    case let .updateMyProfile(task):
      params = params.merging(task.asDictionary()) { $1 }
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
  }
}
