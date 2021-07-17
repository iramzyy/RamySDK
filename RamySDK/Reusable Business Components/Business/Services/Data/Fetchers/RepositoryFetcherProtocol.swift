//
//  RepositoryFetcherProtocol.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 29/06/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import Foundation

public protocol RepositoryFetcherProtocol {
  func fetch<T: Cachable, U: BaseEndpoint>(_ fetchRequirements: RepositoryFetchRequirements<T, U>, onFetch: @escaping Handler<T>)
}
