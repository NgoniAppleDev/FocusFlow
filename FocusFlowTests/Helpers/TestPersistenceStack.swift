//
//  TestPersistenceStack.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftData
@testable import FocusFlow

@MainActor
struct TestPersistenceStack {
    
    let container: ModelContainer
    let context: ModelContext
    let repository: SwiftDataHabitRepository
    
    init() throws {
        
        let container = try TestModelContainer.make()
        let context = TestModelContext.make(from: container)
        let repository = TestSwiftDataHabitRepository.make(from: context)
        
        self.container = container
        self.context = context
        self.repository = repository
    }
}
