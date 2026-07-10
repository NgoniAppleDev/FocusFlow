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
    var order: Int = 0
    
    @Relationship(deleteRule: .cascade)
    var completions: [HabitCompletion] = []
    
    init(name: String) {
        self.name = name
    }
}

extension Habit {
    
    var isCompletedToday: Bool {
        completions.contains { Calendar.current.isDateInToday($0.date) }
    }
    
    func hasCompletion(on date: Date) -> Bool {
        completions.contains { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
    
    func toggleCompletion(on date: Date) {
        if hasCompletion(on: date) {
            removeCompletion(on: date)
        } else {
            addCompletion(on: date)
        }
    }
    
    private func addCompletion(on date: Date) {
        completions.append(HabitCompletion(date: date))
    }
    
    private func removeCompletion(on date: Date) {
        completions.removeAll { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}

extension Habit: CustomStringConvertible {
    
    var description: String {
        return "Habit(name: \(name), order: \(order), completionsCount: \(completions.count))"
    }
}
