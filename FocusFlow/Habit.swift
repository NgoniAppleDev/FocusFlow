//
//  Habit.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import Foundation

struct Habit {
    let name: String
    var isCompleted: Bool
    
    mutating func toggle() {
        isCompleted.toggle()
    }
}
