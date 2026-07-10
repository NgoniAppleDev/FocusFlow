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
    func addingHabitDelegatesToRepository() throws {
        
        let repository = SpyHabitRepository()
        
        let viewModel = HabitListViewModel(repository: repository)
        
        viewModel.add(name: "Workout")
        
        let addedHabit = try #require(repository.addedHabit)
        
        #expect(addedHabit.name == "Workout")
    }
    
    @Test
    func toggleCompletionDelegatesToRepository() {
        
        let repository = SpyHabitRepository()
        
        let viewModel = HabitListViewModel(repository: repository)
        
        let habit = makeHabit()
        let today = Date.now
        
        viewModel.toggleCompletion(habit, on: today)
        
        #expect(repository.toggledHabit === habit)
        #expect(repository.toggledDate == today)
    }
    
    @Test
    func deleteHabitsDelegatesToRepository() throws {
        
        let repository = SpyHabitRepository()
        
        let viewModel = HabitListViewModel(repository: repository)
        
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
        
        let viewModel = HabitListViewModel(repository: repository)
        
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
    
    @Test
    func addingEmptyHabitNameDoesNotCallRepository() throws {
        
        let repository = SpyHabitRepository()
        
        let viewModel = HabitListViewModel(repository: repository)
        
        viewModel.add(name: " ")
        
        let error = try #require(viewModel.error)
        
        #expect(error == .emptyHabitName)
        #expect(repository.addedHabit == nil)
    }
    
    @Test(
        arguments: [
            (ViewModelAction.add, HabitError.unableToSave),
            (.toggle, .unableToToggle),
            (.delete, .unableToDelete),
            (.move, .unableToUpdateOrder)
        ]
    )
    func repositoryFailureSetsErrorMessage(action: ViewModelAction, expectedError: HabitError) throws {
        
        let repository = FailingHabitRepository()
        
        let viewModel = HabitListViewModel(repository: repository)
        
        let habit = makeHabit()
        
        switch action {
        case .add:
            viewModel.add(name: "Workout")
        case .toggle:
            viewModel.toggleCompletion(habit, on: .now)
        case .delete:
            viewModel.delete([habit], at: IndexSet([0]))
        case .move:
            viewModel.move([makeHabit(name: "Eat less food"), habit], from: IndexSet([0]), to: 1)
        }
        
        let error = try #require(viewModel.error)
        
        #expect(error == expectedError)
    }

}
