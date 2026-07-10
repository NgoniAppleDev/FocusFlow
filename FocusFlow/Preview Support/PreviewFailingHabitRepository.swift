//
//  PreviewFailingHabitRepository.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Foundation

final class PreviewFailingHabitRepository: HabitRepository {
    
    func add(_ habit: Habit) throws {
        throw HabitError.unableToSave
    }
    
    func delete(_ habits: [Habit]) throws {
        throw HabitError.unableToDelete
    }
    
    func toggleCompletion(_ habit: Habit, on date: Date) throws {
        throw HabitError.unableToToggle
    }
    
    func updateOrder(of habits: [Habit]) throws {
        throw HabitError.unableToUpdateOrder
    }
}
