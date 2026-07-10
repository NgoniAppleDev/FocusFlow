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
        
        var errorMessage: String?
        
        init(repository: any HabitRepository) {
            self.repository = repository
        }
        
        func add(_ habit: Habit) {
            do {
                try repository.add(habit)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        
        func toggleCompletion(_ habit: Habit, on date: Date) {
            do {
                try repository.toggleCompletion(habit, on: date)
            }  catch {
                errorMessage = error.localizedDescription
            }
        }
        
        func delete(_ habits: [Habit], at offsets: IndexSet) {
            do {
                let habitsToDelete = offsets.map { habits[$0] }
                try repository.delete(habitsToDelete)
            }  catch {
                errorMessage = error.localizedDescription
            }
        }
        
        func move(_ habits: [Habit], from indexSet: IndexSet, to destination: Int) {
            do {
                var reorderedHabits = habits
                reorderedHabits.move(fromOffsets: indexSet, toOffset: destination)
                try repository.updateOrder(of: reorderedHabits)
            }  catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
