//
//  DefaultStreakCalculatorTests.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 9/7/2026.
//

import Testing
import Foundation
@testable import FocusFlow

private extension Date {
    
    static func make(
        day: Int,
        month: Int = 1,
        year: Int = 2026
    ) -> Date {
        Calendar.current.date(
            from: DateComponents(
                year: year,
                month: month,
                day: day
            )
        )!
    }
}

@Suite("Default Streak Calculator Test", .tags(.domain))
struct DefaultStreakCalculatorTests {
    
    private let calculator = DefaultStreakCalculator()

    
    // MARK: - Best Streak Tests
    
    @Test
    func emptyHistoryHasZeroBestStreak() {
        let result = calculator.bestStreak(from: [])
        
        #expect(result == 0)
    }
    
    @Test
    func singleCompletionHasOneDayBestStreak() {
        
        let completions = [
            CompletionEvent(date: .make(day: 5))
        ]
        
        let result = calculator.bestStreak(from: completions)
        
        #expect(result == 1)
    }
    
    @Test
    func consecutiveCompletionsIncreaseBestStreak() {
        
        let completions = [
            CompletionEvent(date: .make(day: 3)),
            CompletionEvent(date: .make(day: 4)),
            CompletionEvent(date: .make(day: 5)),
        ]
        
        let result = calculator.bestStreak(from: completions)
        
        #expect(result == 3)
    }
    
    @Test
    func missingDayBreaksBestStreak() {
        
        let completions = [
            CompletionEvent(date: .make(day: 1)),
            CompletionEvent(date: .make(day: 2)),
            CompletionEvent(date: .make(day: 4)),
            CompletionEvent(date: .make(day: 5))
        ]
        
        let result = calculator.bestStreak(from: completions)
        
        #expect(result == 2)
    }
    
    @Test
    func duplicateSameDayCompletionsCountAsOneDay() {
        let completions = [
            CompletionEvent(date: .make(day: 8, month: 7)),
            CompletionEvent(date: .make(day: 9, month: 7)),
            CompletionEvent(date: .make(day: 9, month: 7)),
        ]
        let result = calculator.bestStreak(from: completions)
        
        #expect(result == 2)
    }
    
    
    // MARK: - Current Streak Tests
    
    @Test
    func completingTodayCreatesOneDayCurrentStreak() {
        
        let today = Date.make(day: 9, month: 7)
        let completions = [
            CompletionEvent(date: today)
        ]
        let result = calculator.currentStreak(from: completions, today: today)
        
        #expect(result == 1)
        
    }
    
    @Test
    func consecutiveDaysEndingTodayCreateCurrentStreak() {
        
        let today = Date.make(day: 9, month: 7)
        let completions = [
            CompletionEvent(date: .make(day: 8, month: 7)),
            CompletionEvent(date: .make(day: 9, month: 7)),
        ]
        let result = calculator.currentStreak(from: completions, today: today)
        
        #expect(result == 2)
    }
    
    @Test
    func missingTodayResetsCurrentStreak() {
        
        let today = Date.make(day: 9, month: 7)
        let completions = [
            CompletionEvent(date: .make(day: 7, month: 7)),
            CompletionEvent(date: .make(day: 8, month: 7)),
        ]
        let result = calculator.currentStreak(from: completions, today: today)
        
        #expect(result == 0)
    }
    
    @Test
    func missingDayBreaksCurrentStreak() {
        
        let today = Date.make(day: 9, month: 7)
        let completions = [
            CompletionEvent(date: .make(day: 6, month: 7)),
            CompletionEvent(date: .make(day: 7, month: 7)),
            CompletionEvent(date: .make(day: 9, month: 7)),
        ]
        let result = calculator.currentStreak(from: completions, today: today)
        
        #expect(result == 1)
    }

}
