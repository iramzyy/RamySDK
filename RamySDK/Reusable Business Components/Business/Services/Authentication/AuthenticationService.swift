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
    
  func register(with task: RegisterTask, onDone: @escaping Handler<Void>)
  func login(_ onDone: @escaping Handler<Void>)
  func sendOTP(to phoneNumber: String, onVerification: @escaping Handler<Void>)
  func authenticate(withOTP otp: String, onAuthentication: @escaping Handler<Void>)
  
  func verifyUserLocally(preferredMethod: VerificationMethod, onAuth: @escaping Handler<Void>)
  
  func logout()
}

public final class AuthenticationService: AuthenticationServiceProtocol {
  
  private lazy var phoneAuth: PhoneAuthServiceProtocol = PhoneAuthService()
  private lazy var biometricAuth: BiometricPinAuthServiceProtocol = BiometricPinAuthService()
  private lazy var sessionTimer: SessionTimerServiceProtocol = SessionTimerService()
  
  public lazy var userToken: String? = try? ServiceLocator.shared.cacheManager.fetch(String.self, for: .userToken)
  private var disposeBag = DisposeBag()
  
  public lazy var user: BehaviorRelay<User?> = {
    let cachedUser = try? ServiceLocator.shared.cacheManager.fetch(User.self, for: .user)
    return BehaviorRelay(value: cachedUser)
  }()
  
  init() {
    bindCallbacks()
  }
}

// MARK: - Local Verification
public extension AuthenticationService {
  func verifyUserLocally(preferredMethod: VerificationMethod, onAuth: @escaping Handler<Void>) {
//    biometricAuth.authenticate(through: preferredMethod) { results in
//      switch results {
//      case .success:
//        onAuth(.success(()))
//      case let .failure(error):
//        switch error {
//        case InternalError.iOSCantAuthenticateUserLocally:
//          break
//        default:
//          LoggersManager.error(error.localizedDescription)
//        }
//        onAuth(.failure(error))
//      }
//    }
  }
}

// MARK: - RamySDK's Authentication
public extension AuthenticationService {
  func register(with task: RegisterTask, onDone: @escaping Handler<Void>) {
    ServiceLocator
      .shared
      .network
      .call(
        api: AuthEndpoint.register(task),
        model: User.self) { [weak self] (results) in
        guard let self = self else { return }
        switch results {
        case let .success(user):
          self.user.accept(user)
          try? ServiceLocator.shared.cacheManager.save(user, for: .encryptedUser)
          try? ServiceLocator.shared.cacheManager.save(user.toInsensitive(), for: .user)
          onDone(.success(()))
        case let .failure(error):
          onDone(.failure(error))
        }
      }
  }
  
  func login(_ onDone: @escaping Handler<Void>) {
    ServiceLocator
      .shared
      .network
      .call(
        api: AuthEndpoint.login,
        model: User.self
      ) { [weak self] (results) in
        guard let self = self else { return }
        switch results {
        case let .success(user):
          self.user.accept(user)
          try? ServiceLocator.shared.cacheManager.save(user, for: .encryptedUser)
          try? ServiceLocator.shared.cacheManager.save(user.toInsensitive(), for: .user)
          onDone(.success(()))
        case let .failure(error):
          onDone(.failure(error))
        }
      }
  }
}

// MARK: - Firebase OTP Handling
public extension AuthenticationService {
  func sendOTP(to phoneNumber: String, onVerification: @escaping Handler<Void>) {
    phoneAuth.sendOTP(to: phoneNumber, onVerification: onVerification)
  }
  
  func authenticate(withOTP otp: String, onAuthentication: @escaping Handler<Void>) {
    phoneAuth.authenticate(with: otp) { [weak self] (results) in
      guard let self = self else { return }
      switch results {
      case let .success(user):
        user.getIDToken { (token, error) in
          guard error == nil else {
            onAuthentication(.failure("Failed to create a token".localized().asError))
            return
          }
          
          guard let token = token else {
            onAuthentication(.failure("Failed to create a token".localized().asError))
            return
          }
          
          self.userToken = token
          try? ServiceLocator.shared.cacheManager.save(token, for: .userToken)
          onAuthentication(.success(()))
        }
      case let .failure(error):
        onAuthentication(.failure(error))
      }
    }
  }
}

// MARK: - Logout
public extension AuthenticationService {
  func logout() {
    do {
      try Auth.auth().signOut()
      try ServiceLocator.shared.cacheManager.remove(type: User.Insensitive.self, for: .user)
      try ServiceLocator.shared.cacheManager.remove(type: User.self, for: .encryptedUser)
      try ServiceLocator.shared.cacheManager.remove(type: String.self, for: .userToken)
      
      SceneDelegate.restartSubject.on(.next(()))
    } catch {
      LoggersManager.error(error.localizedDescription.tagWith(.firebase))
    }
  }
}

// MARK: - Logic
private extension AuthenticationService {
  func bindCallbacks() {
    sessionTimer.onTimerFinish = { [weak self] in
//      guard let topViewController = UIViewController.topMostViewController as? BaseViewController else { return }
//      let vc = LocalVerificationViewController()
//      let vm = LocalVerificationViewModel(router: vc.router)
//      vc.bind(to: vm)
//      topViewController.router.push(vc)
    }
  }
}
