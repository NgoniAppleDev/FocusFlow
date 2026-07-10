//
//  HabitRepository.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import Foundation

protocol HabitRepository {
    func add(_ habit: Habit) throws
    func toggleCompletion(_ habit: Habit, on date: Date) throws
    func delete(_ habits: [Habit]) throws
    func updateOrder(of habits: [Habit]) throws
}
