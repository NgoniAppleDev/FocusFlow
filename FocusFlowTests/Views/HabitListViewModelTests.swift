//
//  HabitListViewModelTests.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Testing
import Foundation
@testable import FocusFlow

private extension HabitListViewModelTests {
    
    func makeHabit(name: String = "Workout") -> Habit {
        .init(name: name)
    }
}

struct HabitListViewModelTests {

    @Test
    func addingHabitDelegatesToRepository() {
        
        let repository = SpyHabitRepository()
        
        let viewModel = HabitListView.ViewModel(repository: repository)
        
        let habit = makeHabit()
        
        viewModel.add(habit)
        
        #expect(repository.addedHabit === habit)
    }
    
    @Test
    func toggleCompletionDelegatesToRepository() {
        
        let repository = SpyHabitRepository()
        
        let viewModel = HabitListView.ViewModel(repository: repository)
        
        let habit = makeHabit()
        let today = Date.now
        
        viewModel.toggleCompletion(habit, on: today)
        
        #expect(repository.toggledHabit === habit)
        #expect(repository.toggledDate == today)
    }
    
    @Test
    func deleteHabitsDelegatesToRepository() throws {
        
        let repository = SpyHabitRepository()
        
        let viewModel = HabitListView.ViewModel(repository: repository)
        
        let habits: [Habit] = [makeHabit(), makeHabit(), makeHabit()]
        let offsets = IndexSet([1])
        
        viewModel.delete(habits, at: offsets)
        
        let deletedHabits = try #require(repository.deletedHabits)
        
        #expect(deletedHabits.count == 1)
        #expect(deletedHabits.first === habits[1])
    }

}
