//
//  HabitRepository.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import Foundation

protocol HabitRepository {
    func add(_ habit: Habit)
    func toggleCompletion(_ habit: Habit, on date: Date)
    func delete(_ habits: [Habit])
    func updateOrder(of habits: [Habit])
}
