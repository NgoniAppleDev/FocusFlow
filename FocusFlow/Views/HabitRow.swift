//
//  HabitRow.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftUI

struct HabitRow: View {
    
    let habit: Habit
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Text(habit.name)
                .foregroundStyle(habit.hasCompletion(on: .now) ? .secondary : .primary)
            
            Spacer()
            
            Image(systemName: habit.hasCompletion(on: .now) ? "checkmark.circle.fill" : "circle")
        }
        .contentShape(.rect)
        .onTapGesture(perform: onToggle)
    }
}

#Preview {
    HabitRow(habit: .init(name: "Workout"), onToggle: {})
}
