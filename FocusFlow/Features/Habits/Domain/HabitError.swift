//
//  HabitError.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Foundation

enum HabitError: LocalizedError, Equatable, Identifiable {
    
    case emptyHabitName
    case unableToSave
    case unableToDelete
    case unableToUpdateOrder
    case unableToToggle
    
    var id: Self { self }
    
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
        case .unableToToggle:
            "Could not toggle completion of habit."
        }
    }
    
    var recoverySuggestion: String {
        switch self {
        case .emptyHabitName:
            "Please enter a habit name."
        default:
            "Please try again."
        }
    }
    
    var userMessage: String {
        [errorDescription, recoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
    }
}
