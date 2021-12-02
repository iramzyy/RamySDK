//
//  UITextField+Publisher.swift
//  SQ10
//
//  Created by Ahmed Ramy on 25/10/2021.
//

import Combine
import UIKit

extension UITextField {
    func onTextChange() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }

    func onStopTextChange() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }

    func bind(with subject: CurrentValueSubject<String, Never>,
              storeIn subscriptions: inout Set<AnyCancellable>)
    {
        subject.sink { [weak self] value in
            if value != self?.text {
                self?.text = value
            }
        }.store(in: &subscriptions)

        onTextChange().sink { value in
            if value != subject.value {
                subject.value = value
            }
        }.store(in: &subscriptions)
    }
}
