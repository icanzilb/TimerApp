//
//  CountdownTimer.swift
//  TimerApp
//
//  Created by Marin Todorov on 4/5/20.
//  Copyright © 2020 Underplot ltd. All rights reserved.
//

import Foundation
import Combine

class Counter {
    private var subscriptions = Set<AnyCancellable>()
    private let timer = Timer
        .publish(every: 1, on: RunLoop.main, in: .common)
        .autoconnect()
        .scan(0, { counter, _ in counter + 1 })
        .eraseToAnyPublisher()
    
    let shared = CurrentValueSubject<Int, Never>(0)
    
    init() {
        timer
            .subscribe(shared)
            .store(in: &subscriptions)
    }
}
