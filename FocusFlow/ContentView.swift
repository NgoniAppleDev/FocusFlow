//
//  ContentView.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 7/7/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var habits: [Habit] = [
        .init(name: "Workout", isCompleted: false),
        .init(name: "Read", isCompleted: false),
        .init(name: "Practice Swift", isCompleted: false)
    ]
    
    @State private var showingCreateHabit = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits.indices, id: \.self) { index in
                    HStack {
                        Text(habits[index].name)
                            .strikethrough(habits[index].isCompleted)
                            .foregroundStyle(habits[index].isCompleted ? .secondary : .primary)
                        
                        Spacer()
                        
                        Image(systemName: habits[index].isCompleted ? "checkmark.circle.fill" : "circle")
                    }
                    .onTapGesture {
                        habits[index].toggle()
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
        habits.append(newHabit)
    }
}

#Preview {
    ContentView()
}
