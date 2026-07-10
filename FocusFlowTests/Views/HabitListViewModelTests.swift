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

@Suite("Habit List ViewModel Tests", .tags(.viewModel))
struct HabitListViewModelTests {
    
    enum ViewModelAction {
        case add
        case toggle
        case delete
        case move
    }

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
    
    @Test
    func reorderingHabitsDelegatesToRepository() throws {
        
        let repository = SpyHabitRepository()
        
        let viewModel = HabitListView.ViewModel(repository: repository)
        
        let eatHabit = makeHabit(name: "Eat")
        let sleepHabit = makeHabit(name: "Sleep")
        let drinkCoffeeHabit = makeHabit(name: "Drink Coffee")
        let writeCodeHabit = makeHabit(name: "Write Code")
        
        let habits: [Habit] = [ eatHabit, sleepHabit, drinkCoffeeHabit, writeCodeHabit ]
        let originOffsets = IndexSet([1])
        let destination = 3
        
        viewModel.move(habits, from: originOffsets, to: destination)
        
        let updatedHabits = try #require(repository.updatedHabits)
        
        #expect(updatedHabits.count == 4)
        #expect(updatedHabits == [ eatHabit, drinkCoffeeHabit, sleepHabit, writeCodeHabit ])
    }
    
    @Test(arguments: [ViewModelAction.add, .toggle, .delete, .move])
    func repositoryFailureSetsErrorMessage(action: ViewModelAction) throws {
        
        let repository = FailingHabitRepository()
        
        let viewModel = HabitListView.ViewModel(repository: repository)
        
        let habit = makeHabit()
        
        switch action {
        case .add:
            viewModel.add(habit)
        case .toggle:
            viewModel.toggleCompletion(habit, on: .now)
        case .delete:
            viewModel.delete([habit], at: IndexSet([0]))
        case .move:
            viewModel.move([makeHabit(name: "Eat less food"), habit], from: IndexSet([0]), to: 1)
        }
        
        let errorMessage = try #require(viewModel.errorMessage)
        
        #expect(errorMessage == TestsConstants.expectedErrorMessage)
    }

}
