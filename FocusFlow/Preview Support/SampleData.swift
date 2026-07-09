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
            .init(name: "Workout"),
            .init(name: "Read"),
            .init(name: "Practice Swift"),
            .init(name: "Walk the dog"),
        ]
    }
}
