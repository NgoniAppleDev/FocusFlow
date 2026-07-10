//
//  FailingHabitRepository.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Foundation
@testable import FocusFlow

final class FailingHabitRepository: HabitRepository {
    
    enum TestError: LocalizedError {
        case saveFailed
        
        var errorDescription: String? {
            "Something went wrong"
        }
    }
    
    func add(_ habit: Habit) throws {
        throw TestError.saveFailed
    }
    
    func delete(_ habits: [Habit]) throws {
        throw TestError.saveFailed
    }
    
    func toggleCompletion(_ habit: Habit, on date: Date) throws {
        throw TestError.saveFailed
    }
    
    func updateOrder(of habits: [Habit]) throws {
        throw TestError.saveFailed
    }
}
