//
//  HabitList.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftUI

struct HabitList: View {
    
    let habits: [Habit]
    let action: (HabitListIntent) -> Void
    
    var body: some View {
        List {
            ForEach(habits) { habit in
                HabitRow(habit: habit) { rowAction in
                    switch rowAction {
                    case .toggleCompletion:
                        action(.toggle(habit))
                    }
                }
            }
            .onDelete { action(.delete($0)) }
            .onMove { action(.move($0, $1)) }
        }
    }
}

#Preview {
    HabitList(
        habits: [.init(name: "Workout"), .init(name: "Read"), .init(name: "Piano")],
        action: { _ in }
    )
}
