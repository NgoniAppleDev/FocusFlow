//
//  HabitErrorTests.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Testing
@testable import FocusFlow

struct HabitErrorTests {

    @Test
    func emptyHabitNameProvidesHelpfulMessage() throws {
        
        let error = HabitError.emptyHabitName
        
        let description = try #require(error.errorDescription)
        
        #expect(description == "Habit name cannot be empty.")
    }
    
    @Test(arguments: [
        HabitError.unableToSave,
        .emptyHabitName,
        .unableToDelete,
        .unableToToggle,
        .unableToUpdateOrder
    ])
    func habitActionFailuresHaveADescription(habitError: HabitError) throws {
        
        #expect(habitError.errorDescription != nil)
    }
    
    @Test(arguments: [
        HabitError.unableToSave,
        .unableToDelete,
        .unableToToggle,
        .unableToUpdateOrder
    ])
    func repositoryFailuresProvideRecoverySuggestion(
        habitError: HabitError
    ) {
        #expect(
            habitError.recoverySuggestion == "Please try again."
        )
    }

}
