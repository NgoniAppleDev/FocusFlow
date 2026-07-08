//
//  HabitListViewModel.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import SwiftData
import SwiftUI

extension HabitListView {
    
    final class ViewModel {
        
        func add(_ habit: Habit, using modelContext: ModelContext, currentCount: Int) {
            habit.order = currentCount
            
            modelContext.insert(habit)
            
            save(using: modelContext)
        }
        
        func toggle(_ habit: Habit, using modelContext: ModelContext) {
            habit.toggle()
            save(using: modelContext)
        }
        
        func delete(_ habits: [Habit], at offsets: IndexSet, using modelContext: ModelContext) {
            for index in offsets {
                let habit = habits[index]
                modelContext.delete(habit)
            }
            
            save(using: modelContext)
        }
        
        func move(_ habits: [Habit], from indexSet: IndexSet, to newOffset: Int, using modelContext: ModelContext) {
            var reorderedHabits = habits
            
            reorderedHabits.move(fromOffsets: indexSet, toOffset: newOffset)
            
            for (index, habit) in reorderedHabits.enumerated() {
                habit.order = index
            }
            
            save(using: modelContext)
        }
        
        private func save(using modelContext: ModelContext) {
            do {
                try modelContext.save()
            } catch {
                // FIXME: should remove print statement when going into production.
                print(error)
            }
        }
    }
}
