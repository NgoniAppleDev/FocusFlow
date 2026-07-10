//
//  PreviewContainer.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import Foundation
import SwiftData

class PreviewContainer {
    
    @MainActor static let shared = PreviewContainer()
    
    let container: ModelContainer
    let modelContext: ModelContext
    let habitRepository: any HabitRepository
    
    private init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        
        do {
            container = try ModelContainer(for: Habit.self, configurations: configuration)
            
            modelContext = ModelContext(container)
            
            habitRepository = SwiftDataHabitRepository(modelContext: modelContext)
            
            for (index, habit) in SampleData.habits().enumerated() {
                habit.order = index
                
                if index.isMultiple(of: 2) {
                    habit.toggleCompletion(on: .now)
                }
                
                modelContext.insert(habit)
            }
            
            try modelContext.save()
            
        }  catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }
}
