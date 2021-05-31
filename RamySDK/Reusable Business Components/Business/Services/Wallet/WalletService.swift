//
//  WalletService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/04/2021.
//

import RxCocoa

public protocol WalletServiceProtocol {
  var defaultWallet: BehaviorRelay<Wallet?> { get set }
  func syncWallet(onSync: @escaping Handler<Void>)
  func isUserTransferringToHisAccounts(_ fromAccount: String) -> Bool // TODO: - Dummy, Should be changed after Integration
}

public final class WalletService: WalletServiceProtocol {
  public lazy var defaultWallet: BehaviorRelay<Wallet?> = {
    let cachedWallet = try? cache.fetch(Wallet.self, for: .defaultWallet)
    return BehaviorRelay<Wallet?>(value: cachedWallet)
  }()
  
  public static let dummyCurrentUserAccounts: [String] = ["My Account", "Account 1", "Account 2", "Account 3"]
  public static let dummyCurrentUserContactsAccount: [String] = ["Account A", "Account B", "Account C", "Account D"]
  
  private let cache: CacheManager
  
  init(
    cache: CacheManager = ServiceLocator.shared.cacheManager
  ) {
    self.cache = cache
  }
  
  public func isUserTransferringToHisAccounts(_ fromAccount: String) -> Bool {
    return Self.dummyCurrentUserAccounts.contains(fromAccount)
  }
  
  public func syncWallet(onSync: @escaping Handler<Void>) {
    let requirements: RepositoryFetchRequirements<Wallet, WalletEndpoint> = .init(
      key: .defaultWallet,
      api: .getMyWallet,
      fetchPriority: .cacheFirstThenNetwork,
      updateStrategy: .updateCache
    )
    
    ServiceLocator.shared.add(expected: Wallet.mockedDefault)
    
    ServiceLocator.shared.repository.fetch(fetchRequirements: requirements) { [weak self] (results) in
      guard let self = self else { return }
      switch results {
      case let .success(wallet):
        self.defaultWallet.accept(wallet)
        onSync(.success(()))
      case let .failure(error):
        onSync(.failure(error))
      }
    }
  }
}
