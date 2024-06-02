//
//  Matrix.swift
//  quickyquicky
//
//  Created by Kirill Efremov on 26.05.2024.
//

import SwiftUI

struct Matrix: View {
    @Binding var matrix: [Number]
    let onClick: (Number) -> Void
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
            ForEach(matrix, id: \.id) { number in
                Text("\(number.value)")
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
                    .onTapGesture {
                        onClick(number)
                    }
            }
        }
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

#Preview {
    Matrix(matrix: Binding(get: { Array((900...919)).map({ Number(id: UUID(), value: $0, state: .NotPassed) }) }, set: {_ in}), onClick: {_ in})
}
