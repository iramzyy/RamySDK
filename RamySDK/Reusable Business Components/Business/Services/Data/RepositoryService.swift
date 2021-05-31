//
//  RepositoryService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import Foundation

public protocol RepositoryServiceProtocol: Service {
  func fetch<T: Cachable, U: BaseEndpoint>(fetchRequirements: RepositoryFetchRequirements<T, U>, onFetch: @escaping Handler<T>)
}

public struct RepositoryFetchRequirements<T: Codable, U: BaseEndpoint> {
  let key: StorageKey
  let api: U
  let fetchPriority: DataFetchPriority
  let updateStrategy: DataUpdateStrategy
}

/// Determines The Fetching Priority, If a step failed, the next one comes
public enum DataFetchPriority {
  case cacheFirstThenNetwork
  case networkOnly
  case cacheOnly
  case networkFirstThenCache
}

public enum DataUpdateStrategy {
  case updateCache
  case ignoreCacheUpdate
}

public final class RepositoryService: RepositoryServiceProtocol {
  
  private let network: NetworkProtocol
  private let cache: CacheManager
    
  private var fetchers = [RepositoryFetcherProtocol]()
  
  private lazy var cacheFetcher = CacheFetcher(cache: self.cache)
  private lazy var networkFetcher = NetworkFetcher(network: self.network)
  
  init(
    network: NetworkProtocol = ServiceLocator.shared.network,
    cache: CacheManager = ServiceLocator.shared.cacheManager
  ) {
    self.network = network
    self.cache = cache
  }
  
  public func fetch<T: Cachable, U: BaseEndpoint>(fetchRequirements: RepositoryFetchRequirements<T, U>, onFetch: @escaping Handler<T>) {
    switch fetchRequirements.fetchPriority {
    case .cacheFirstThenNetwork:
      self.fetchers = [cacheFetcher, networkFetcher]
      executeFetching(fetchRequirements: fetchRequirements, onSuccess: { (model) in
        onFetch(.success(model))
      }, onFailure: { error in
        onFetch(.failure(error))
      })
    case .networkFirstThenCache:
      self.fetchers = [networkFetcher, cacheFetcher]
      executeFetching(fetchRequirements: fetchRequirements, onSuccess: { (model) in
        onFetch(.success(model))
      }, onFailure: { error in
        onFetch(.failure(error))
      })
    case .cacheOnly:
      self.fetchers = [cacheFetcher]
      executeFetching(fetchRequirements: fetchRequirements, onSuccess: { (model) in
        onFetch(.success(model))
      }, onFailure: { error in
        onFetch(.failure(error))
      })
    case .networkOnly:
      self.fetchers = [networkFetcher]
      executeFetching(fetchRequirements: fetchRequirements, onSuccess: { (model) in
        onFetch(.success(model))
      }, onFailure: { error in
        onFetch(.failure(error))
      })
    }
  }
  
  private func executeFetching<T: Cachable, U: BaseEndpoint>(fetchRequirements: RepositoryFetchRequirements<T, U>, onSuccess: @escaping Callback<T>, onFailure: @escaping Callback<Error>) {
    let fetcher = self.fetchers.removeFirst()
    fetcher.fetch(fetchRequirements, onFetch: { [weak self] results in
      guard let self = self else { return }
      switch results {
      case let .failure(error):
        guard !self.fetchers.isEmpty else {
          onFailure(error)
          return
        }
        self.executeFetching(fetchRequirements: fetchRequirements, onSuccess: onSuccess, onFailure: onFailure)
      case let .success(model):
        onSuccess(model)
        guard fetcher is CacheFetcher == false else { return }
        switch fetchRequirements.updateStrategy {
        case .updateCache:
          do {
            try self.cache.save(model, for: fetchRequirements.key)
          } catch {
            LoggersManager.error(error.localizedDescription)
          }
        case .ignoreCacheUpdate:
          break
        }
      }
    })
  }
}
