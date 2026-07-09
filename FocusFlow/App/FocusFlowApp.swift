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
    
    private let appContainer = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            HabitListView(repository: appContainer.habitRepository)
        }
        .modelContainer(appContainer.container)
    }
}
