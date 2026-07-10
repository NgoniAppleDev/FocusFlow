//
//  HabitListRootView.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 9/7/2026.
//

import SwiftUI
import SwiftData

struct HabitListRootView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HabitListView(
            viewModel: .init(
                repository: SwiftDataHabitRepository(modelContext: modelContext)
            )
        )
    }
}

#Preview {
    HabitListRootView()
}
