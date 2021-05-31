//
//  RepositoryFetcherProtocol.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import Foundation

public protocol RepositoryFetcherProtocol {
  func fetch<T: Cachable, U: BaseEndpoint>(_ fetchRequirements: RepositoryFetchRequirements<T, U>, onFetch: @escaping Handler<T>)
}
