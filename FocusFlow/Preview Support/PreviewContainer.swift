//
//  PreviewContainer.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import Foundation
import SwiftData

class PreviewContainer {
    
    static let shared = PreviewContainer()
    
    let container: ModelContainer
    let modelContext: ModelContext
    
    private init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        
        do {
            container = try ModelContainer(for: Habit.self, configurations: configuration)
            
            modelContext = ModelContext(container)
            
            SampleData.habits.enumerated().forEach { index, habit in
                habit.order = index
                modelContext.insert(habit)
            }
            
            try modelContext.save()
            
        }  catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }
    
    
}

extension PreviewContainer {
    
    var habitRepository: HabitRepository {
        HabitRepository(modelContext: modelContext)
    }
}
