//
//  MockedNetworkManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 16/04/2021.
//

import Foundation

final class MockedNetworkLayer: NetworkProtocol {
  
  var didRemoveOldRequests: Bool = false
  var calledAPIs = [BaseEndpoint]()
  var object: Codable?
  var objects = [Codable]()
  var error: Error?
  var shouldWait = false
  var continueAction: (() -> Void)?
  var didCallNetwork: Bool {
    return calledAPIs.count > 0
  }
  var shouldSimulateRealLifeRequest: Bool = true
  
  func removePreviousCall() {
    didRemoveOldRequests = true
  }
  
  func call<T: Codable, U: BaseEndpoint>(api: U, model: T.Type, _ onFetch: @escaping (Result<T, Error>) -> Void) {
    calledAPIs.append(api)
    if shouldSimulateRealLifeRequest {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        if self.objects.isEmpty == false, let object = self.objects.removeFirst() as? T {
          onFetch(.success(object))
        } else if let object = self.object as? T {
          onFetch(.success(object))
        } else {
          onFetch(.failure(self.error ?? LocalError.genericError))
        }
      }
    } else if shouldWait {
      continueAction = {
        if self.objects.isEmpty == false, let object = self.objects.removeFirst() as? T {
          onFetch(.success(object))
        } else if let object = self.object as? T {
          onFetch(.success(object))
        } else {
          onFetch(.failure(self.error ?? LocalError.genericError))
        }
      }
    } else {
      if self.objects.isEmpty == false, let object = self.objects.removeFirst() as? T {
        onFetch(.success(object))
      } else if let object = self.object as? T {
        onFetch(.success(object))
      } else {
        onFetch(.failure(self.error ?? LocalError.genericError))
      }
    }
  }
  
  init() { }
  
  init(error: Error) {
    self.error = error
  }
  
  init(object: Codable) {
    self.object = object
  }
}

