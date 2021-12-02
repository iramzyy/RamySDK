//
//  UIButton+Publisher.swift
//  SQ10
//
//  Created by Ahmed Ramy on 25/10/2021.
//

import Combine
import Foundation
import UIKit

extension UIButton {
    func onTap() -> AnyPublisher<Void, Never> {
        publisher(for: .touchUpInside)
            .map { _ in
            }
            .eraseToAnyPublisher()
    }

    func bind<T>(_ key: ReferenceWritableKeyPath<UIButton, T>, with publisher: AnyPublisher<T, Never>, storeIn subscriptions: inout Set<AnyCancellable>) {
        publisher.sink { value in
            self[keyPath: key] = value
        }.store(in: &subscriptions)
    }
}
