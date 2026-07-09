//
//  DefaultStreakCalculator.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 9/7/2026.
//

import Foundation

struct DefaultStreakCalculator: StreakCalculating {
    
    func currentStreak(from completions: [CompletionEvent], today: Date = .now) -> Int {
        
        let calendar = Calendar.current
        
        guard completions.contains(where: { calendar.isDate($0.date, inSameDayAs: today) }) else {
            return 0
        }
        
        let dates = completions.map(\.date).sorted(by: >)
        
        guard let firstDate = dates.first else { return 0 }
        
        var streak = 0
        var currentDate = firstDate
        
        for date in dates {
            
            if calendar.isDate(date, inSameDayAs: currentDate) {
                streak += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            } else { break }
        }
        
        return streak
    }
    
    func bestStreak(from completions: [CompletionEvent]) -> Int {
        let calendar = Calendar.current
        
        let dates = completions.map(\.date).sorted(by: >)
        
        guard !dates.isEmpty else { return 0 }
        
        var currentStreak = 1
        var bestStreak = 1
        
        for index in 1..<dates.count {
            let previousDate = dates[index - 1]
            let currentDate = dates[index]
            
            let expectedDate = calendar.date(byAdding: .day, value: -1, to: previousDate)!
            
            if calendar.isDate(currentDate, inSameDayAs: expectedDate) {
                currentStreak += 1
            } else {
                currentStreak = 1
            }
            
            bestStreak = max(bestStreak, currentStreak)
        }
        
        return bestStreak
        
    }
}
