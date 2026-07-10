//
//  SpyStreakCalculator.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation
@testable import FocusFlow

final class SpyStreakCalculator: StreakCalculating {
    
    var receivedCompletions: [CompletionEvent]?
    
    var currentStreakResult = 0
    var bestStreakResult = 0
    
    func bestStreak(from completions: [CompletionEvent]) -> Int {
        receivedCompletions = completions
        return bestStreakResult
    }
    
    func currentStreak(from completions: [CompletionEvent], today: Date) -> Int {
        receivedCompletions = completions
        return currentStreakResult
    }
}
