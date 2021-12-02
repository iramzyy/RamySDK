//
//  UIControl+Publisher.swift
//  SQ10
//
//  Created by Ahmed Ramy on 25/10/2021.
//

import Combine
import UIKit

extension UIControl {
    /// Allows UIControl elements to have `RxSwift` like `rx` operator, only this time using, publisher
    ///
    /// - Usage:
    /// ```
    /// textField.publisher(for: .editingChanged)
    /// ```
    func publisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        UIControl.EventPublisher(control: self, controlEvent: event)
    }

    /// Creating a publisher for the UIControl
    struct EventPublisher: Publisher {
        // we are passing in the data stream the uicontrol as value
        typealias Output = UIControl
        typealias Failure = Never

        let control: UIControl
        let controlEvent: UIControl.Event

        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = EventSubscription(control: control, event: controlEvent, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }

    /// The subscription is where the main work is done
    class EventSubscription<S: Subscriber>: Subscription
        where S.Input == UIControl, S.Failure == Never
    {
        let control: UIControl
        let event: UIControl.Event
        var subscriber: S?

        var currentDemand = Subscribers.Demand.none

        init(control: UIControl, event: UIControl.Event, subscriber: S) {
            self.control = control
            self.event = event
            self.subscriber = subscriber

            control.addTarget(self,
                              action: #selector(eventOccured),
                              for: event)
        }

        func request(_ demand: Subscribers.Demand) {
            currentDemand += demand
        }

        func cancel() {
            subscriber = nil
            control.removeTarget(self,
                                 action: #selector(eventOccured),
                                 for: event)
        }

        @objc func eventOccured() {
            if currentDemand > 0 {
                currentDemand += subscriber?.receive(control) ?? .none
                currentDemand -= 1
            }
        }
    }
}
