//
//  BiometricPinAuthService.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 29/04/2021.
//

import BiometricAuthentication

public protocol BiometricPinAuthServiceProtocol: Service {
  func authenticate(through preferredMethod: VerificationMethod, _ onAuth: @escaping Handler<Void>)
}

public final class BiometricPinAuthService: BiometricPinAuthServiceProtocol {
  public func authenticate(through preferredMethod: VerificationMethod, _ onAuth: @escaping Handler<Void>) {
    guard BioMetricAuthenticator.canAuthenticate() else {
      onAuth(.failure(InternalError.iOSCantAuthenticateUserLocally))
      return
    }
    
    switch preferredMethod {
    case .biometric:
      authenticateThroughBiometricAndFallbackToPin(onAuth)
    case .pin:
      authenticateThroughPinAndFallbackToBiometric(onAuth)
    }
  }
}

private extension BiometricPinAuthService {
  private func authenticateThroughBiometricAndFallbackToPin(_ onAuth: @escaping Handler<Void>) {
    BioMetricAuthenticator.authenticateWithBioMetrics(reason: .empty, completion: { results in
      switch results {
      case .success:
        onAuth(.success(()))
      case .failure:
        BioMetricAuthenticator.authenticateWithPasscode(reason: .empty) { (results) in
          switch results {
          case .success:
            onAuth(.success(()))
          case let .failure(error):
            onAuth(.failure(error))
          }
        }
      }
    })
  }
  
  private func authenticateThroughPinAndFallbackToBiometric(_ onAuth: @escaping Handler<Void>) {
    BioMetricAuthenticator.authenticateWithPasscode(reason: .empty, completion: { results in
      switch results {
      case .success:
        onAuth(.success(()))
      case .failure:
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: .empty) { (results) in
          switch results {
          case .success:
            onAuth(.success(()))
          case let .failure(error):
            onAuth(.failure(error))
          }
        }
      }
    })
  }
}
