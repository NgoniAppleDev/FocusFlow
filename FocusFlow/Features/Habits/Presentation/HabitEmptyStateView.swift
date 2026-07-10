//
//  HabitEmptyStateView.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftUI

struct HabitEmptyStateView: View {
    
    let onAddHabit: () -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label("No Habits", systemImage: "checklist")
        } description: {
            Text("Create a habit to get started")
        } actions: {
            Button("Add Habit", systemImage: "plus", action: onAddHabit)
            .buttonStyle(.glassProminent)
            .controlSize(.extraLarge)
        }
    }
}

#Preview {
    HabitEmptyStateView(onAddHabit: { })
}
