//
//  HabitTests.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Testing
import Foundation
@testable import FocusFlow

private extension Date {
    static var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: .now)!
    }
}

private extension HabitTests {
    func makeHabit(name: String = "Watch Solo Leveling") -> Habit {
        .init(name: name)
    }
}

struct HabitTests {
    
    @Test
    func newHabitIsNotCompletedToday() {
        
        let habit = makeHabit()
        
        #expect(!habit.isCompletedToday)
    }
    
    @Test
    func completingTodayMarksHabitCompletedToday() {
        
        let habit = makeHabit()
        habit.toggleCompletion(on: .now)
        
        #expect(habit.isCompletedToday)
    }
    
    @Test
    func completingTodayCreatesCompletionEvent() {
        
        let habit = makeHabit()
        habit.toggleCompletion(on: .now)
        
        #expect(habit.completions.count == 1)
    }
    
    @Test
    func togglingCompletionTwiceUndoesCompletion() {
        
        let habit = makeHabit()
        habit.toggleCompletion(on: .now)
        habit.toggleCompletion(on: .now)
        
        #expect(habit.completions.count == 0)
    }
    
    @Test
    func undoRemovesTodayCompletion() {
        
        let habit = makeHabit()
        habit.toggleCompletion(on: .now)
        habit.toggleCompletion(on: .now)
        
        #expect(!habit.isCompletedToday)
        #expect(habit.completions.isEmpty)
    }
    
    @Test
    func undoTodayOnlyRemovesTodayCompletion() {
        
        let habit = makeHabit()
        
        habit.toggleCompletion(on: .yesterday)
        habit.toggleCompletion(on: .now)
        habit.toggleCompletion(on: .now)
        
        #expect(!habit.isCompletedToday)
        #expect(habit.hasCompletion(on: .yesterday))
        #expect(habit.completions.count == 1)
        
    }
    
    
    @Test
    func completionYesterdayDoesNotCountAsCompletedToday() {
        
        let habit = makeHabit()
        
        habit.toggleCompletion(on: .yesterday)
        
        #expect(!habit.isCompletedToday)
    }
    
    @Test
    func hasCompletionReturnsTrueForCompletedDate() {
        
        let habit = makeHabit()
        
        habit.toggleCompletion(on: .yesterday)
        
        #expect(habit.hasCompletion(on: .yesterday))
    }
    
    @Test
    func hasCompletionReturnsFalseForIncompleteDate() {
        
        let habit = makeHabit()
        
        habit.toggleCompletion(on: .now)
        
        #expect(!habit.hasCompletion(on: .yesterday))
    }
    
    @Test
    func completingDifferentDaysCreatesMultipleCompletionEvents() {
        
        let habit = makeHabit()
        
        habit.toggleCompletion(on: .now)
        habit.toggleCompletion(on: .yesterday)
        
        #expect(habit.completions.count == 2)
    }
    
}
