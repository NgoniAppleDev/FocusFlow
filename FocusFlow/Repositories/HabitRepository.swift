//
//  HabitRepository.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

protocol HabitRepository {
    func add(_ habit: Habit)
    func toggle(_ habit: Habit)
    func delete(_ habits: [Habit])
    func updateOrder(of habits: [Habit])
}
