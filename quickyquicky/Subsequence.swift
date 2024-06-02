//
//  SubsequenceView.swift
//  quickyquicky
//
//  Created by Kirill Efremov on 26.05.2024.
//

import SwiftUI

struct Subsequence: View {
    @Binding var subsequence: [Number]
    
    var body: some View {
        HStack {
            ForEach(subsequence, id: \.id) { number in
                Text(String(number.value)).gameNumber(number: number, action: {})
            }
        }
    }
}

#Preview {
    Subsequence(subsequence: Binding(get: { [999, 999, 999, 999].map({ Number(id: UUID(), value: $0, state: .NotPassed) }) }, set: {_ in}))
}
