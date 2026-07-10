//
//  ModelContext+Extension.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftData

extension ModelContext {
    
    func fetchHabits() throws -> [Habit] {
        try fetch(FetchDescriptor<Habit>())
    }
    
    func fetchHabitsCount() throws -> Int {
        try fetchCount(FetchDescriptor<Habit>())
    }
}
