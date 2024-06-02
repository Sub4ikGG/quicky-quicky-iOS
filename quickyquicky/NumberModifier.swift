//
//  NumberModifier.swift
//  quickyquicky
//
//  Created by Kirill Efremov on 26.05.2024.
//

import Foundation
import SwiftUI

struct NumberModifier: ViewModifier {
    let number: Number
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(action: action, label: {
            content
                .padding()
                .font(.system(size: 24))
                .fontWeight(.medium)
                .frame(width: 80, height: 80)
                .foregroundStyle(numberForegroundStyle(state: number.state))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(numberBackground(state: number.state))
                )
                .frame(maxWidth: .infinity)
        })
    }
    
    
    private func numberBackground(state: NumberState) -> Color {
        return switch (state) {
        case .NotPassed: Color.surfaceBackground
        case .Passed: Color.surfacePassed
        case .Failed: Color.surfaceFailed
        }
    }
    
    private func numberForegroundStyle(state: NumberState) -> Color {
        return switch (state) {
        case .NotPassed: Color.black
        default: Color.white
        }
    }
}

extension View {
    func gameNumber(
        number: Number,
        action: @escaping () -> Void
    ) -> some View {
        modifier(NumberModifier(number: number, action: action))
    }
}
