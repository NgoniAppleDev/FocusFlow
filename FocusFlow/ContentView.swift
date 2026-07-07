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
    
    var body: some View {
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
    }
}

#Preview {
    ContentView()
}
