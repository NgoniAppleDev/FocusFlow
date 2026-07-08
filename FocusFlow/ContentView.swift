//
//  ContentView.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]
    
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
                                habit.toggle()
                            }
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
            }
            .sheet(isPresented: $showingCreateHabit) {
                NavigationStack {
                    CreateHabitView(onCreate: addHabit(_:))
                }
            }
        }
    }
    
    private func addHabit(_ newHabit: Habit) {
        modelContext.insert(newHabit)
        do {
            try modelContext.save()
        } catch {
            // FIXME: should remove print statement when going into production.
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
