//
//  Habit.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftData

@Model
final class Habit {
    var name: String
    var isCompleted: Bool
    var order: Int = 0
    
    init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
    }
    
    func toggle() {
        isCompleted.toggle()
    }
}
