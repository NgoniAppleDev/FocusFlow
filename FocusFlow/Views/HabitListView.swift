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
    @State private var viewModel: ViewModel
    @State private var showingCreateHabit = false
    
    init(repository: HabitRepository) {
        _viewModel = State(initialValue: ViewModel(
            repository: repository
        ))
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if habits.isEmpty {
                    ContentUnavailableView {
                        Label("No Habits", systemImage: "checklist")
                    } description: {
                        Text("Create a habit to get started")
                    } actions: {
                        Button("Add Habit", systemImage: "plus") {
                            showingCreateHabit = true
                        }
                        .buttonStyle(.glassProminent)
                        .controlSize(.extraLarge)
                    }
                } else {
                    List {
                        ForEach(habits) { habit in
                            HStack {
                                Text(habit.name)
                                    .strikethrough(habit.isCompleted)
                                    .foregroundStyle(habit.isCompleted ? .secondary : .primary)
                                
                                Spacer()
                                
                                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                            .onTapGesture {
                                viewModel.toggle(habit)
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
            }
            .navigationTitle("FocusFlow")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") {
                        showingCreateHabit = true
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingCreateHabit) {
                NavigationStack {
                    CreateHabitView { newHabit in
                        viewModel.add(newHabit, currentCount: habits.count)
                    }
                }
            }
        }
    }
}

#Preview {
    HabitListView(repository: PreviewContainer.shared.habitRepository)
        .modelContainer(PreviewContainer.shared.container)
}
