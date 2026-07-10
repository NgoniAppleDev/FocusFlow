//
//  Collection+Testing.swift
//  FocusFlowTests
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Testing

extension Collection {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}
