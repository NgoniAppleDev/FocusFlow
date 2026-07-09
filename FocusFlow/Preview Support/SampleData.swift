//
//  SampleData.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 8/7/2026.
//

import Foundation

enum SampleData {
    
    static func habits() -> [Habit] {
        [
            .init(name: "Workout", isCompleted: true),
            .init(name: "Read"),
            .init(name: "Practice Swift", isCompleted: true),
            .init(name: "Walk the dog"),
        ]
    }
}
