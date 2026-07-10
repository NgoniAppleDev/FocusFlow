//
//  String+Extensions.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import Foundation

extension String {
    var isTrimmedEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var trimmedString: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
