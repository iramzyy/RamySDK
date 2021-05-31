//
//  Aliases.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 9/30/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public typealias Handler<T> = (Result<T, Error>) -> Void
public typealias ProgressiveHandler<T> = (AsyncProgress<T>) -> Void
public typealias Callback<T> = (_: T) -> Void
public typealias VoidCallback = () -> Void

public enum AsyncProgress<T> {
  case loadingStep(String)
  case finished(T)
  case failed(Error)
}
