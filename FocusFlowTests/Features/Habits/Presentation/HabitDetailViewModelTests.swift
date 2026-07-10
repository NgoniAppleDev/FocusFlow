//
//  HabitDetailViewModelTests.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Testing
import Foundation
@testable import FocusFlow

private extension HabitDetailViewModelTests {
    
    func makeHabit(name: String = "Workout") -> Habit {
        .init(name: name)
    }
}

struct HabitDetailViewModelTests {

    @Test
    func calculatingStreakUsesCalculator() {
        
        let calculator = SpyStreakCalculator()
        calculator.currentStreakResult = 7
        
        let habit = makeHabit()
        
        let viewModel = HabitDetailViewModel(
            habit: habit,
            repository: SpyHabitRepository(),
            streakCalculator: calculator
        )
        
        #expect(viewModel.currentStreak == 7)
    }
    
    @Test
    func bestStreakUsesCalculator() {
        
        let calculator = SpyStreakCalculator()
        calculator.bestStreakResult = 14
        
        let habit = makeHabit()
        
        let viewModel = HabitDetailViewModel(
            habit: habit,
            repository: SpyHabitRepository(),
            streakCalculator: calculator
        )
        
        #expect(viewModel.bestStreak == 14)
    }
    
    @Test
    func currentStreakPassesCompletionEventsToCalculator() throws {
        
        let calculator = SpyStreakCalculator()
        
        let habit = makeHabit()
        habit.completions = [
            .init(date: .now)
        ]
        
        let viewModel = HabitDetailViewModel(
            habit: habit,
            repository: SpyHabitRepository(),
            streakCalculator: calculator
        )
        
        _ = viewModel.currentStreak
        
        let completions = try #require(calculator.receivedCompletions)
        
        #expect(completions.count == 1)
    }

}
