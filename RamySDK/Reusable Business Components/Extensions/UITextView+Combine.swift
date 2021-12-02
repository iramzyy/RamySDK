//
//  UITextView+Combine.swift
//  SQ10
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Combine
import Foundation
import UIKit

extension UITextView {
    func onTextChange() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextView)?.text }
            .eraseToAnyPublisher()
    }

    func onStopTextChange() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidEndEditingNotification, object: self)
            .compactMap { ($0.object as? UITextView)?.text }
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
                subject.send(value)
            }
        }.store(in: &subscriptions)
    }
}
