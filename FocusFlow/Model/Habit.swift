//
//  Habit.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftData
import SwiftUI

@Model
final class Habit {
    var name: String
    var isCompleted: Bool
    var order: Int = 0
    var lastCompletedDate: Date? = nil
    
    init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
    }
    
    func toggle() {
        isCompleted.toggle()
        
        if isCompleted {
            lastCompletedDate = .now
        } else if let lastCompletedDate, Calendar.current.isDateInToday(lastCompletedDate) {
            self.lastCompletedDate = nil
        }
        
        print("\nHabit Toggled:")
        print(self.name, self.isCompleted, self.lastCompletedDate)
    }
}
