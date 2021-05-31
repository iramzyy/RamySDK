//
//  CacheFetcher.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import Foundation

public final class CacheFetcher: RepositoryFetcherProtocol {
  
  let cache: CacheManager
  
  init(
    cache: CacheManager = ServiceLocator.shared.cacheManager
  ) {
    self.cache = cache
  }
  
  public func fetch<T: Cachable, U: BaseEndpoint>(_ fetchRequirements: RepositoryFetchRequirements<T, U>, onFetch: @escaping (Result<T, Error>) -> Void) {
    do {
      try onFetch(.success(cache.fetch(T.self, for: fetchRequirements.key)))
    } catch {
      onFetch(.failure(error))
    }
  }
}
