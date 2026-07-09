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
        
        private let repository: any HabitRepository
        
        init(repository: any HabitRepository) {
            self.repository = repository
        }
        
        func add(_ habit: Habit) {
            repository.add(habit)
        }
        
        func toggleCompletion(_ habit: Habit, on date: Date) {
            repository.toggleCompletion(habit, on: date)
        }
        
        func delete(_ habits: [Habit], at offsets: IndexSet) {
            let habitsToDelete = offsets.map { habits[$0] }
            repository.delete(habitsToDelete)
        }
        
        func move(_ habits: [Habit], from indexSet: IndexSet, to destination: Int) {
            var reorderedHabits = habits
            reorderedHabits.move(fromOffsets: indexSet, toOffset: destination)
            repository.updateOrder(of: reorderedHabits)
        }
    }
}
