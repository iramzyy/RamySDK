//
//  AuthenticationService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 02/04/2021.
//

import RxCocoa
import RxSwift

public protocol AuthenticationServiceProtocol: Service {
  var userToken: String? { get set }
  var user: BehaviorRelay<User?> { get set }
}

public final class AuthenticationService: AuthenticationServiceProtocol {
  public lazy var userToken: String? = try? ServiceLocator.shared.cacheManager.fetch(String.self, for: .userToken)
  private var disposeBag = DisposeBag()
  
  public lazy var user: BehaviorRelay<User?> = {
    let cachedUser = try? ServiceLocator.shared.cacheManager.fetch(User.self, for: .user)
    return BehaviorRelay(value: cachedUser)
  }()
  
  init() {}
}
