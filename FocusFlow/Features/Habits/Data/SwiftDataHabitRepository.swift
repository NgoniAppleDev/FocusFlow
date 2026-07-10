//
//  SwiftDataHabitRepository.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 9/7/2026.
//

import SwiftData
import SwiftUI

final class SwiftDataHabitRepository: HabitRepository {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func add(_ habit: Habit) throws {
        let count = (try? modelContext.fetchHabitsCount()) ?? 0
        habit.order = count
        modelContext.insert(habit)
        try save()
    }
    
    func toggleCompletion(_ habit: Habit, on date: Date) throws {
        habit.toggleCompletion(on: date)
        try save()
    }
    
    func delete(_ habits: [Habit]) throws {
        for habit in habits {
            modelContext.delete(habit)
        }
        try save()
    }
    
    func updateOrder(of habits: [Habit]) throws {
        for (index, habit) in habits.enumerated() {
            habit.order = index
        }
        try save()
    }
    
    private func save() throws {
        try modelContext.save()
    }
}
