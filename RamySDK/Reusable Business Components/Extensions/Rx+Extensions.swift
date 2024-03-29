//
//  Rx+Extensions.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/17/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import RxSwift

extension ObservableType {
    /**
     Repeats the source observable sequence until given attempts number. Each repeat is delayed exponentially.
     - parameter maxAttemptCount: Maximum number of times to repeat the sequence.
     - parameter jitter: Range allowing to randomize delay time
     - parameter scheduler: Scheduler on which the delay will be conducted
     - parameter onRetry: Action which will be invoked after delay on every retry
     */
    public func retryExponentially(maxAttemptCount: Int = 3,
                                   randomizedRange jitter: ClosedRange<Double> = 0.9...1.1,
                                   scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()),
                                   onRetry: ((Error) -> Void)? = nil) -> Observable<Element> {
        guard maxAttemptCount > 0 else { return Observable.empty() }

        return Observable.create({
            let disposable = SerialDisposable()
            self.handleExponentialBackOffObserver(observer: $0,
                                trial: 0,
                                maxAttemptCount: maxAttemptCount,
                                disposable: disposable,
                                with: jitter,
                                scheduler: scheduler,
                                onRetry: onRetry)
            return disposable
        })
    }

    private func handleExponentialBackOffObserver(observer: AnyObserver<Element>,
                                trial: Int,
                                maxAttemptCount: Int,
                                disposable: SerialDisposable,
                                with jitter: ClosedRange<Double>,
                                scheduler: SchedulerType,
                                onRetry: ((Error) -> Void)?) {

        let delayTimeInSeconds = exp(Double(trial)) * Double.random(in: jitter)
        let delayTimeInMiliseconds = Int(floor(delayTimeInSeconds * 1000))

        disposable.disposable = self
            .delaySubscription(DispatchTimeInterval.milliseconds(delayTimeInMiliseconds),
                               scheduler: scheduler)
            .subscribe({ event in
                switch event {
                case .next(let element): observer.onNext(element)
                case .completed: observer.onCompleted()
                case .error(let error):
                    onRetry?(error)
                    guard trial < (maxAttemptCount - 1) else {
                        observer.onError(error)
                        return
                    }
                    self.handleExponentialBackOffObserver(observer: observer,
                                        trial: trial + 1,
                                        maxAttemptCount: maxAttemptCount,
                                        disposable: disposable,
                                        with: jitter,
                                        scheduler: scheduler,
                                        onRetry: onRetry)
                }
            })

    }
}
