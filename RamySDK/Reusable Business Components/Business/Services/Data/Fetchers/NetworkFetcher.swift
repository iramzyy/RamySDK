//
//  NetworkFetcher.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import Foundation

public final class NetworkFetcher: RepositoryFetcherProtocol {
  
  let network: NetworkProtocol
  
  init(
    network: NetworkProtocol = ServiceLocator.shared.network
  ) {
    self.network = network
  }
  
  public func fetch<T: Codable, U: BaseEndpoint>(_ fetchRequirements: RepositoryFetchRequirements<T, U>, onFetch: @escaping (Result<T, Error>) -> Void) {
    network.call(api: fetchRequirements.api, model: T.self, { results in
      switch results {
      case .success(let model):
        onFetch(.success(model))
      case .failure(let error):
        onFetch(.failure(error))
      }
    })
  }
}
