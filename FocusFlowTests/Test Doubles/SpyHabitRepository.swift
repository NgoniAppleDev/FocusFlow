//
//  SpyHabitRepository.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Testing
import Foundation
@testable import FocusFlow

final class SpyHabitRepository: HabitRepository {
    
    var addedHabit: Habit?
    
    var toggledHabit: Habit?
    var toggledDate: Date?
    
    var deletedHabits: [Habit]?
    
    var updatedHabits: [Habit]?
    
    func add(_ habit: Habit) {
        addedHabit = habit
    }
    
    func toggleCompletion(_ habit: Habit, on date: Date) {
        toggledHabit = habit
        toggledDate = date
    }
    
    func delete(_ habits: [Habit]) {
        deletedHabits = habits
    }
    
    func updateOrder(of habits: [Habit]) {
        updatedHabits = habits
    }
}
