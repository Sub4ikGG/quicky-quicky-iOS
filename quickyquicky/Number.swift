//
//  Number.swift
//  quickyquicky
//
//  Created by Kirill Efremov on 26.05.2024.
//

import Foundation

enum NumberState {
    case NotPassed
    case Passed
    case Failed
}

struct Number: Identifiable {
    let id: UUID
    let value: Int
    let state: NumberState
}
