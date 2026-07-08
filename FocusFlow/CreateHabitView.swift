//
//  CreateHabitView.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftUI

extension String {
    var isTrimmedEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var trimmedString: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct CreateHabitView: View {
    @State private var habitName = ""
    @Environment(\.dismiss) private var dismiss
    
    let onCreate: (Habit) -> Void
    
    var body: some View {
        Form {
            TextField("name", text: $habitName)
        }
        .navigationTitle("New Habit")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) { dismiss() }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Create", role: .confirm) {
                    let newHabit = Habit(name: habitName.trimmedString, isCompleted: false)
                    
                    onCreate(newHabit)
                    
                    dismiss()
                }
                .disabled(habitName.isTrimmedEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateHabitView(onCreate: { _ in })
    }
}
