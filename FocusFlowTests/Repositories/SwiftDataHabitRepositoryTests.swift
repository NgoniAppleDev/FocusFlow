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
        
        let descriptor = FetchDescriptor<Habit>()
        let habits = try stack.context.fetch(descriptor)
        
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
        
        stack.repository.toggleCompletion(habit, on: .now)
        
        #expect(habit.isCompletedToday)
    }

}
