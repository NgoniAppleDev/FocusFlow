//
//  HabitRepository.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import Foundation

protocol HabitRepository {
    func add(_ habit: Habit, currentCount: Int)
    func toggle(_ habit: Habit)
    func delete(_ habits: [Habit])
    func move(_ habits: [Habit], from indexSet: IndexSet, to destination: Int)
}
