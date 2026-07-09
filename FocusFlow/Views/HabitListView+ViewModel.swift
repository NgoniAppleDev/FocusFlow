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
        
        private let repository: HabitRepository
        
        init(repository: HabitRepository) {
            self.repository = repository
        }
        
        func add(_ habit: Habit, currentCount: Int) {
            repository.add(habit, currentCount: currentCount)
        }
        
        func toggle(_ habit: Habit) {
            repository.toggle(habit)
        }
        
        func delete(_ habits: [Habit], at offsets: IndexSet) {
            repository.delete(habits, at: offsets)
        }
        
        func move(_ habits: [Habit], from indexSet: IndexSet, to destination: Int) {
            repository.move(habits, from: indexSet, to: destination)
        }
    }
}
