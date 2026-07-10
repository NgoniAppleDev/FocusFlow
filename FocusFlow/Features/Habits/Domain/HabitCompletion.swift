//
//  HabitCompletion.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 9/7/2026.
//

import Foundation
import SwiftData

@Model
final class HabitCompletion {
    
    var date: Date
    
    init(date: Date) {
        self.date = date
    }
}
