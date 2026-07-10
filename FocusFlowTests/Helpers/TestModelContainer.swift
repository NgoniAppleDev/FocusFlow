//
//  TestModelContainer.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftData
@testable import FocusFlow

@MainActor
enum TestModelContainer {
    
    static func make() throws -> ModelContainer {
        
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        
        return try ModelContainer(for: Habit.self, configurations: configuration)
    }
}
