//
//  CorePlugin.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/18/20\.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import UIKit

struct CorePlugin { }

extension CorePlugin: ApplicationPlugin {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    setupServiceLocator()
    return true
  }
  
  private func setupServiceLocator() {
    let network = MockedNetworkLayer()
    let cache = CacheManager()
    ServiceLocator.shared = ServiceLocator(
      network: network,
      cacheManager: cache,
      auth: AuthenticationService(),
      repository: RepositoryService(
        network: network,
        cache: cache
      )
    )
  }
}
