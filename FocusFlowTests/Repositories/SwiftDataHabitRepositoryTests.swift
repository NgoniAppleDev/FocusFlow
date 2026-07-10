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
        try stack.repository.add(habit)
        
        let habits = try stack.context.fetchHabits()
        
        #expect(habits.count == 1)
        
        let savedHabit = try #require(habits.first)
        
        #expect(savedHabit.name == "Workout")
    }
    
    @Test
    func addingHabitPlacesItAtEndOfOrder() throws {
        
        let stack = try TestPersistenceStack()
        
        try stack.repository.add(makeHabit(name: "Workout"))
        try stack.repository.add(makeHabit(name: "Reading"))
        
        let newHabit = makeHabit(name: "Meditation")
        
        try stack.repository.add(newHabit)
        
        #expect(newHabit.order == 2)
    }
    
    @Test
    func togglingCompletionPersistsChange() throws {
        
        let stack = try TestPersistenceStack()
        
        let habit = makeHabit()
        
        try stack.repository.add(habit)
        
        let date = Date.now
        
        try stack.repository.toggleCompletion(habit, on: date)
        
        let savedHabits = try stack.context.fetchHabits()
        
        let savedHabit = try #require(savedHabits.first)
        
        #expect(savedHabit.isCompletedToday)
        #expect(savedHabit.hasCompletion(on: date))
    }
    
    @Test
    func deletingHabitRemovesHabit() throws {
        
        let stack = try TestPersistenceStack()
        
        let habit = makeHabit()
        try stack.repository.add(habit)
        try stack.repository.delete([habit])
        
        let habits = try stack.context.fetchHabits()
        
        #expect(habits.isEmpty)
    }
    
    @Test
    func deletingHabitRemovesOnlyThatHabit() throws {
        
        let stack = try TestPersistenceStack()
        
        let habitToBeDeleted = makeHabit()
        try stack.repository.add(habitToBeDeleted)
        try stack.repository.add(makeHabit())
        try stack.repository.add(makeHabit())
        
        try stack.repository.delete([habitToBeDeleted])
        
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
        
        try stack.repository.add(workout)
        try stack.repository.add(eat)
        try stack.repository.add(sleep)
        
        try stack.repository.updateOrder(of: [sleep, workout, eat])
        
        #expect(sleep.order == 0)
        #expect(workout.order == 1)
        #expect(eat.order == 2)
    }

}
