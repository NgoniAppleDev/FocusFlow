//
//  HabitError.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Foundation

enum HabitError: LocalizedError {
    
    case emptyHabitName
    case unableToSave
    case unableToDelete
    case unableToUpdateOrder
    
    var errorDescription: String? {
        switch self {
        case .emptyHabitName:
            "Habit name cannot be empty."
        case .unableToSave:
            "The habit could not be saved."
        case .unableToDelete:
            "The habit could not be deleted."
        case .unableToUpdateOrder:
            "The habit order could not be updated."
        }
    }
}
