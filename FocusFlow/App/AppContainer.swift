//
//  AppContainer.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import SwiftData

final class AppContainer {
    
    let habitRepository: HabitRepository
    let container: ModelContainer
    let modelContext: ModelContext
    
    init() {
        do {
            container = try ModelContainer(for: Habit.self)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        modelContext = ModelContext(container)
        habitRepository = .init(modelContext: modelContext)
    }
}
