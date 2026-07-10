//
//  CreateHabitView.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftUI

struct CreateHabitView: View {
    @State private var habitName = ""
    @Environment(\.dismiss) private var dismiss
    
    let onCreate: (String) -> Void
    
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
                    
                    onCreate(habitName.trimmedString)
                    
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
