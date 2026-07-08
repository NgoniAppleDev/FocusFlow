//
//  HabitListView.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftUI
import SwiftData

struct HabitListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Habit.order)
    private var habits: [Habit]
    
    @State private var viewModel: ViewModel = .init()
    @State private var showingCreateHabit = false
    
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
                                viewModel.toggle(habit, using: modelContext)
                            }
                        }
                        .onDelete { indexSet in
                            viewModel.delete(habits, at: indexSet, using: modelContext)
                        }
                        .onMove { indices, destination in
                            viewModel.move(habits, from: indices, to: destination, using:modelContext)
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
                        viewModel.add(newHabit, using: modelContext, currentCount: habits.count)
                    }
                }
            }
        }
    }
}

#Preview {
    HabitListView()
        .modelContainer(PreviewContainer.container)
}
