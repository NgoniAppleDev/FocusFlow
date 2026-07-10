//
//  HabitListIntent.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Foundation

enum HabitListIntent {
    
    case toggle(Habit)
    case delete(IndexSet)
    case move(IndexSet, Int)
}
