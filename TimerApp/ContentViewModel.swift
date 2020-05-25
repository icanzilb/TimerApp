//
//  ConentViewModel.swift
//  TimerApp
//
//  Created by Marin Todorov on 4/5/20.
//  Copyright © 2020 Underplot ltd. All rights reserved.
//

import Foundation
import CoreGraphics
import Combine

class ContentViewModel: ObservableObject {
    private let totalTime: Int
    private var subscriptions = Set<AnyCancellable>()
    private var counter: Counter!

    init(totalTime: Int) {
        self.totalTime = totalTime
    }

    // Model outputs
    @Published var countdown = ""
    @Published var progress = CGFloat(0.0)

    func activate() {
        counter = Counter()
        
        // Counter label
        counter.shared
            .map { "\(self.totalTime - $0)s" }
            .assign(to: \.countdown, on: self)
            .store(in: &subscriptions)

        // Progress bar
        counter.shared
            .map { 1.0 - CGFloat($0) / CGFloat(self.totalTime)}
            .assign(to: \.progress, on: self)
            .store(in: &subscriptions)
        
        // Util
        counter.shared
            .sink(receiveCompletion: { _ in
                self.countdown = ""
            }) { value in
                if self.totalTime < value {
                    self.subscriptions = []
                }
            }
            .store(in: &subscriptions)
    }
}
