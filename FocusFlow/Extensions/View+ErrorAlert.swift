//
//  View+ErrorAlert.swift
//  FocusFlow
//
//  Created by Ngoni Katsidzira  on 10/7/2026.
//

import SwiftUI

extension View {
    
    func errorAlert(
        error: Binding<HabitError?>
    ) -> some View {
        alert(
            isPresented: Binding(
                get: {
                    error.wrappedValue != nil
                },
                set: { isPresented in
                    if !isPresented {
                        error.wrappedValue = nil
                    }
                }
            ),
            error: error.wrappedValue
        ) { _ in
            Button(
                "OK"
            ) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(
                error.recoverySuggestion
            )
        }
    }
}
