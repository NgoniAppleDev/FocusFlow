//
//  HabitRepository.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import SwiftData
import SwiftUI

final class HabitRepository {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func add(_ habit: Habit, currentCount: Int) {
        habit.order = currentCount
        
        modelContext.insert(habit)
        
        save()
    }
    
    func toggle(_ habit: Habit) {
        habit.toggle()
        save()
    }
    
    func delete(_ habits: [Habit], at offsets: IndexSet) {
        for index in offsets {
            let habit = habits[index]
            modelContext.delete(habit)
        }
        
        save()
    }
    
    func move(_ habits: [Habit], from indexSet: IndexSet, to newOffset: Int) {
        var reorderedHabits = habits
        
        reorderedHabits.move(fromOffsets: indexSet, toOffset: newOffset)
        
        for (index, habit) in reorderedHabits.enumerated() {
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
