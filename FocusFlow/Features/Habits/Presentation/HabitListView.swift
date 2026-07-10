//
//  HabitListView.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftUI
import SwiftData

struct HabitListView: View {
    @Query(sort: \Habit.order) private var habits: [Habit]
    
    @State private var viewModel: HabitListViewModel
    @State private var showingCreateHabit = false
    
    init(viewModel: HabitListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
            .navigationTitle("FocusFlow")
            .toolbar {
                HabitListToolbar {
                    showingCreateHabit = true
                }
            }
            .sheet(isPresented: $showingCreateHabit) {
                NavigationStack {
                    CreateHabitView(onCreate: viewModel.add )
                }
            }
            .alert(
                isPresented: Binding(
                    get: { viewModel.error != nil },
                    set: { isPresented in
                        if !isPresented {
                            viewModel.clearError()
                        }
                    }
                ),
                error: viewModel.error) { error in
                    Button("OK") { viewModel.clearError() }
                } message: { error in
                    Text(error.recoverySuggestion)
                }

        }
    }
    
    @ViewBuilder
    private var content: some View {
        if habits.isEmpty {
            HabitEmptyStateView {
                showingCreateHabit = true
            }
        } else {
            HabitList(
                habits: habits,
                onAction: handle,
                onDelete: { viewModel.delete(habits, at: $0) },
                onMove: { viewModel.move(habits, from: $0, to: $1) }
            )
        }
    }
    
    private func handle(_ action: HabitRowAction, habit: Habit) {
        switch action {
        case .toggleCompletion:
            viewModel.toggleCompletion(habit, on: .now)
        }
    }
}

#Preview {
    HabitListView(
        viewModel: .init(repository: PreviewContainer.shared.habitRepository)
    )
    .modelContainer(PreviewContainer.shared.container)
}

#Preview("Error State") {
    HabitListView(
        viewModel: .init(
            repository: PreviewFailingHabitRepository()
        )
    )
    .modelContainer(PreviewContainer.shared.container)
}
