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
                toolbar
            }
            .sheet(isPresented: $showingCreateHabit) {
                NavigationStack {
                    CreateHabitView(onCreate: viewModel.add(_:))
                }
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
            habitList
        }
    }
    
    private var habitList: some View {
        List {
            ForEach(habits) { habit in
                HabitRow(habit: habit) { action in
                    switch action {
                    case .toggleCompletion:
                        viewModel.toggleCompletion(habit, on: .now)
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.delete(habits, at: indexSet)
            }
            .onMove { indices, destination in
                viewModel.move(habits, from: indices, to: destination)
            }
        }
    }
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Add", systemImage: "plus") {
                showingCreateHabit = true
            }
        }
        
        ToolbarItem(placement: .topBarLeading) {
            EditButton()
        }
    }
}

#Preview {
    HabitListView(
        viewModel: .init(repository: PreviewContainer.shared.habitRepository)
    )
    .modelContainer(PreviewContainer.shared.container)
}
