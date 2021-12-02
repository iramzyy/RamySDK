//
//  UIImageView+Publisher.swift
//  SQ10
//
//  Created by Ahmed Ramy on 08/11/2021.
//

import Combine
import Foundation
import Photos
import UIKit

public extension UIImageView {
    func bind(with subject: CurrentValueSubject<UIImage, Never>,
              storeIn subscriptions: inout Set<AnyCancellable>)
    {
        subject.sink { [weak self] value in
            if value != self?.image {
                self?.image = value
            }
        }.store(in: &subscriptions)
    }
}
