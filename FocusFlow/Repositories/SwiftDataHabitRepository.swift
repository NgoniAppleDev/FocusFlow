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
    
    func add(_ habit: Habit) {
        let descriptor = FetchDescriptor<Habit>()
        let count = (try? modelContext.fetchCount(descriptor)) ?? 0
        habit.order = count
        modelContext.insert(habit)
        save()
    }
    
    func toggle(_ habit: Habit) {
        habit.toggle()
        save()
    }
    
    func delete(_ habits: [Habit]) {
        for habit in habits {
            modelContext.delete(habit)
        }
        save()
    }
    
    func updateOrder(of habits: [Habit]) {
        for (index, habit) in habits.enumerated() {
            habit.order = index
        }
        save()
    }
    
    private func save() {
        do {
            try modelContext.save()
        } catch {
            // FIXME: should remove print statement when going into production.
            print(error)
        }
    }
}
