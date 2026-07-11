//
//  HabitDetailViewModel.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Observation
import Foundation

@Observable
final class HabitDetailViewModel {
    
    private let repository:  any HabitRepository
    private let streakCalculator: any StreakCalculating
    
    let habit: Habit
    var error: HabitError?
    
    init(habit: Habit, repository: any HabitRepository, streakCalculator: any StreakCalculating) {
        self.habit = habit
        self.repository = repository
        self.streakCalculator = streakCalculator
    }
    
    var currentStreak: Int {
        streakCalculator.currentStreak(from: completionEvents, today: .now)
    }
    
    var bestStreak: Int {
        streakCalculator.bestStreak(from: completionEvents)
    }
    
    private var completionEvents: [CompletionEvent] {
        habit.completions.map { CompletionEvent(date: $0.date) }
    }
}
