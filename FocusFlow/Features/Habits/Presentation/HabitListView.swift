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
            .errorAlert(error: $viewModel.error)

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
                action: handle,
            )
        }
    }
    
    private func handle(_ intent: HabitListIntent) {
        switch intent {
        case .toggle(let habit):
            viewModel.toggleCompletion(habit, on: .now)
        case .delete(let offsets):
            viewModel.delete(habits, at: offsets)
        case .move(let offsets, let destination):
            viewModel.move(habits, from: offsets, to: destination)
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
