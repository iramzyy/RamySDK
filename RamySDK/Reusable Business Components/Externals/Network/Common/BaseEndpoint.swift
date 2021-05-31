//
//  BaseEndpoint.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 02/04/2021.
//

import Moya
import CryptoKit

public protocol BaseEndpoint: TargetType { }

public extension BaseEndpoint {
  var baseURL: URL {
    // TODO: - Figure out a way to get this URL from Secure
    URL(string: "https://RamySDK.com/")!
  }
  
  var sampleData: Data {
    .empty
  }
  
  var headers: [String: String]? {
    [
      "Authorization": ServiceLocator.shared.auth.userToken ?? .empty
    ]
  }
  
  var defaultParams: [String: Any] {
    let timestamp = Date().iso8601String
    return [
      "timestamp": timestamp,
      "signature": "\("secret")-\("API Secret")-\(timestamp)-\((ServiceLocator.shared.auth.user.value?.uuid ?? ""))".asHash()
    ]
  }
}

fileprivate extension String {
  func asHash() -> String {
    guard let data = self.data(using: .utf8) else { return .empty }
    return SHA512.hash(data: data).hexStr
  }
}

fileprivate extension Digest {
  var bytes: [UInt8] { Array(makeIterator()) }
  var data: Data { Data(bytes) }
  
  var hexStr: String {
    bytes.map { String(format: "%02X", $0) }.joined()
  }
}
