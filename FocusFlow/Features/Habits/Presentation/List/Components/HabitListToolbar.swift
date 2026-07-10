//
//  HabitListToolbar.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftUI

struct HabitListToolbar: ToolbarContent {
    
    let addAction: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Add", systemImage: "plus", action: addAction)
        }
        
        ToolbarItem(placement: .topBarLeading) {
            EditButton()
        }
    }
}

#Preview {
    NavigationStack {
        Text("Habit List")
            .toolbar {
                HabitListToolbar( addAction: { })
            }
    }
}
