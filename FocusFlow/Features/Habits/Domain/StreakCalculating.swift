//
//  StreakCalculating.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 9/7/2026.
//

import Foundation

protocol StreakCalculating {
    func currentStreak(from completions: [CompletionEvent], today: Date) -> Int
    
    func bestStreak(from completions: [CompletionEvent]) -> Int
}
