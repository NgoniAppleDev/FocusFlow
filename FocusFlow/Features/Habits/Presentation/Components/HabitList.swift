//
//  HabitList.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftUI

struct HabitList: View {
    
    let habits: [Habit]
    let onAction: (_ action: HabitRowAction, Habit) -> Void
    let onDelete: (IndexSet) -> Void
    let onMove: (IndexSet, Int) -> Void
    
    var body: some View {
        List {
            ForEach(habits) { habit in
                HabitRow(habit: habit) { action in
                    onAction(action, habit)
                }
            }
            .onDelete(perform: onDelete)
            .onMove(perform: onMove)
        }
    }
}

#Preview {
    HabitList(
        habits: [.init(name: "Workout"), .init(name: "Read"), .init(name: "Piano")],
        onAction: { (_, _) in },
        onDelete: { _ in },
        onMove: { (_, _) in }
    )
}
