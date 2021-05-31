//
//  BaseModel.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/16/20\.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public class BaseInteractor {
  public var repository: RepositoryServiceProtocol
  
  public init(
    repository: RepositoryServiceProtocol = ServiceLocator.shared.repository
  ) {
    self.repository = repository
  }
}
