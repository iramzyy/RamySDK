//
//  ServiceLocator.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/3/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public final class ServiceLocator {
  
  public static var shared: ServiceLocator!
  
  public var network: NetworkProtocol
  public var cacheManager: CacheManager
  public var auth: AuthenticationServiceProtocol
  public var repository: RepositoryServiceProtocol
  
  init(network: NetworkProtocol,
       cacheManager: CacheManager,
       auth: AuthenticationServiceProtocol,
       repository: RepositoryServiceProtocol
  ) {
    self.network = network
    self.cacheManager = cacheManager
    self.auth = auth
    self.repository = repository
  }
}

// MARK: - Mocked Configurations
public extension ServiceLocator {
  func add(expected codable: Codable) {
    guard let mockedNetwork = network as? MockedNetworkLayer else { return }
    mockedNetwork.objects.append(codable)
    mockedNetwork.object = codable
  }
  
  func add(expected error: Error) {
    guard let mockedNetwork = network as? MockedNetworkLayer else { return }
    mockedNetwork.error = error
  }
}
