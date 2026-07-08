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
    @Query(sort: \Habit.order)
    private var habits: [Habit]
    
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
                        .onDelete(perform: deleteHabits)
                        .onMove { indices, newOffset in
                            moveHabit(from: indices, to: newOffset)
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
                
                ToolbarItem(placement: .secondaryAction) {
                    EditButton()
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
    
    private func deleteHabits(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(habits[index])
        }
    }
    
    private func moveHabit(from indexSet: IndexSet, to newOffset: Int) {
        var reorderedHabits = habits
        
        reorderedHabits.move(fromOffsets: indexSet, toOffset: newOffset)
        
        for (index, habit) in reorderedHabits.enumerated() {
            habit.order = index
        }
        
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.container)
}
