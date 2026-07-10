//
//  TestModelContext.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftData
@testable import FocusFlow

@MainActor
enum TestModelContext {
    
    static func make(from container: ModelContainer) -> ModelContext {
        container.mainContext
    }
}
