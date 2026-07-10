//
//  TestSwiftDataHabitRepository.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftData
@testable import FocusFlow

@MainActor
enum TestSwiftDataHabitRepository {
    
    static func make(from context: ModelContext) -> SwiftDataHabitRepository {
        
        SwiftDataHabitRepository(modelContext: context)
    }
}
