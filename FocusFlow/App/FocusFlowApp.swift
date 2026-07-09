//
//  FocusFlowApp.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftUI
import SwiftData

@main
struct FocusFlowApp: App {
    
    var body: some Scene {
        WindowGroup {
            HabitListRootView()
        }
        .modelContainer(for: Habit.self)
    }
}
