//
//  PreviewContainer.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import Foundation
import SwiftData

enum PreviewContainer {
    
    static let container: ModelContainer = {
       let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        
        do {
            let container = try ModelContainer(for: Habit.self, configurations: configuration)
            
            let context = ModelContext(container)
            
            SampleData.habits.enumerated().forEach { index, habit in
                habit.order = index
                context.insert(habit)
            }
            
            try context.save()
            
            return container
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }()
}
