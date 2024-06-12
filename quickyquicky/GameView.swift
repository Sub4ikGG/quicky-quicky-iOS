//
//  GameView.swift
//  quickyquicky
//
//  Created by Kirill Efremov on 12.06.2024.
//

import SwiftUI

struct GameView: View {
    let subsequence: [Number]
    let matrix: [Number]
    let gameTime: Int
    let winScore: Int
    let loseScore: Int
    
    let selectMatrixNumber: (Number) -> Void
    let giveUp: () -> Void
    
    var body: some View {
        VStack {
            Subsequence(subsequence: subsequence)
            
            Spacer()
            
            HStack {
                Text("\(winScore)")
                    .monospacedDigit()
                    .font(.system(size: 32))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.surfacePassed)
                
                Spacer()
                
                if (gameTime > -1) {
                    Text(String(format: "%02d:%02d", gameTime / 60, gameTime % 60))
                        .monospacedDigit()
                        .font(.system(size: 32))
                        .fontWeight(.medium)
                } else {
                    Text("00:00")
                        .monospacedDigit()
                        .font(.system(size: 32))
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                Text("\(loseScore)")
                    .monospacedDigit()
                    .font(.system(size: 32))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.surfaceFailed)
            }.padding(.horizontal)
            
            Spacer()
            Matrix(
                matrix: matrix,
                onClick: selectMatrixNumber
            )
            Spacer()
            
            Button(action: giveUp, label: {
                Text("Give up")
                    .padding()
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black)
                    )
            })
            .disabled(gameTime <= 0)
        }
    }
}

#Preview {
    GameView(
        subsequence: [999, 999, 999, 999].map({ Number(id: UUID(), value: $0, state: .NotPassed) }),
        matrix: Array((900...919)).map({ Number(id: UUID(), value: $0, state: .NotPassed) }),
        gameTime: 20,
        winScore: 4,
        loseScore: 1,
        selectMatrixNumber: {_ in},
        giveUp: {}
    )
}
