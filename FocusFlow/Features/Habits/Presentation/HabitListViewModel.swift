//
//  HabitListViewModel.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Observation
import SwiftData
import SwiftUI

@Observable
final class HabitListViewModel {
    
    private let repository: any HabitRepository
    
    var error: HabitError?
    
    init(repository: any HabitRepository) {
        self.repository = repository
    }
    
    func add(name: String) {
        
        clearError()
        
        let trimmedName = name.trimmedString
        
        guard !trimmedName.isTrimmedEmpty else {
            error = .emptyHabitName
            return
        }
        
        let habit = Habit(name: trimmedName)
        
        do {
            try repository.add(habit)
        } catch(_) {
            error = .unableToSave
        }
    }
    
    func toggleCompletion(_ habit: Habit, on date: Date) {
        
        clearError()
        
        do {
            try repository.toggleCompletion(habit, on: date)
        }  catch(_) {
            error = .unableToToggle
        }
    }
    
    func delete(_ habits: [Habit], at offsets: IndexSet) {
        
        clearError()
        
        do {
            let habitsToDelete = offsets.map { habits[$0] }
            try repository.delete(habitsToDelete)
        }  catch(_) {
            error = .unableToDelete
        }
    }
    
    func move(_ habits: [Habit], from indexSet: IndexSet, to destination: Int) {
        
        clearError()
        
        do {
            var reorderedHabits = habits
            reorderedHabits.move(fromOffsets: indexSet, toOffset: destination)
            try repository.updateOrder(of: reorderedHabits)
        }  catch(_) {
            error = .unableToUpdateOrder
        }
    }
    
    func clearError() {
        error = nil
    }
}
