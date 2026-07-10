//
//  SwiftDataHabitRepositoryTests.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Testing
import SwiftData
import Foundation
@testable import FocusFlow

private extension SwiftDataHabitRepositoryTests {
    
    func makeHabit(name: String = "Workout") -> Habit {
        .init(name: name)
    }
}

@MainActor
struct SwiftDataHabitRepositoryTests {

    @Test
    func addPersistsHabit() throws {
        
        let stack = try TestPersistenceStack()
        
        let habit = makeHabit(name: "Workout")
        stack.repository.add(habit)
        
        let habits = try stack.context.fetchHabits()
        
        #expect(habits.count == 1)
        
        let savedHabit = try #require(habits.first)
        
        #expect(savedHabit.name == "Workout")
    }
    
    @Test
    func addingHabitPlacesItAtEndOfOrder() throws {
        
        let stack = try TestPersistenceStack()
        
        stack.repository.add(makeHabit(name: "Workout"))
        stack.repository.add(makeHabit(name: "Reading"))
        
        let newHabit = makeHabit(name: "Meditation")
        
        stack.repository.add(newHabit)
        
        #expect(newHabit.order == 2)
    }
    
    @Test
    func togglingCompletionPersistsChange() throws {
        
        let stack = try TestPersistenceStack()
        
        let habit = makeHabit()
        
        stack.repository.add(habit)
        
        let date = Date.now
        
        stack.repository.toggleCompletion(habit, on: date)
        
        let savedHabits = try stack.context.fetchHabits()
        
        let savedHabit = try #require(savedHabits.first)
        
        #expect(savedHabit.isCompletedToday)
        #expect(savedHabit.hasCompletion(on: date))
    }
    
    @Test
    func deletingHabitRemovesHabit() throws {
        
        let stack = try TestPersistenceStack()
        
        let habit = makeHabit()
        stack.repository.add(habit)
        stack.repository.delete([habit])
        
        let habits = try stack.context.fetchHabits()
        
        #expect(habits.isEmpty)
    }
    
    @Test
    func deletingHabitRemovesOnlyThatHabit() throws {
        
        let stack = try TestPersistenceStack()
        
        let habitToBeDeleted = makeHabit()
        stack.repository.add(habitToBeDeleted)
        stack.repository.add(makeHabit())
        stack.repository.add(makeHabit())
        
        stack.repository.delete([habitToBeDeleted])
        
        let habits = try stack.context.fetchHabits()
        
        #expect(habits.count == 2)
        #expect(!habits.contains(where: { $0.id == habitToBeDeleted.id }))
    }
    
    @Test
    func updatingOrderAssignsNewIndices() throws {
        
        let stack = try TestPersistenceStack()
        
        let workout = makeHabit(name: "Workout")
        let eat = makeHabit(name: "Eat")
        let sleep = makeHabit(name: "Sleep")
        
        stack.repository.add(workout)
        stack.repository.add(eat)
        stack.repository.add(sleep)
        
        stack.repository.updateOrder(of: [sleep, workout, eat])
        
        #expect(sleep.order == 0)
        #expect(workout.order == 1)
        #expect(eat.order == 2)
    }

}
