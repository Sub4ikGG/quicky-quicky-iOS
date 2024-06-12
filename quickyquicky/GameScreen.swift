//
//  ContentView.swift
//  quickyquicky
//
//  Created by Kirill Efremov on 26.05.2024.
//

import SwiftUI

struct GameScreen: View {
    private static let GAME_TIME = 15
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var gameTime = -1
    
    @State private var subsequence: [Number] = []
    @State private var matrix: [Number] = []
    
    @State private var winScore = 0
    @State private var loseScore = 0
    
    var body: some View {
        GameView(
            subsequence: subsequence,
            matrix: matrix,
            gameTime: gameTime,
            winScore: winScore,
            loseScore: loseScore,
            selectMatrixNumber: selectMatrixNumber,
            giveUp: {
                initializeGame(delayed: true)
            }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .onAppear { initializeGame(delayed: false) }
        .onReceive(timer) { input in
            gameTime -= 1
            
            if (gameTime < 0) {
                initializeGame()
            }
        }
    }
    
    private func initializeGame(delayed: Bool = true) {
        if (!subsequence.isEmpty) {
            if (subsequence.filter({ $0.state == .NotPassed }).isEmpty) {
                winScore += 1
            } else {
                loseScore += 1
            }
        }
        
        timer.upstream.connect().cancel()
        gameTime = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (delayed ? 1 : 0.0)) {
            let subsequenceArray = (100...999).shuffled().prefix(4).map { Number(id: UUID(), value: $0, state: .NotPassed) }
            
            var matrixArray = (100...999).shuffled().filter { !subsequenceArray.map { $0.value }.contains($0) }.prefix(16).map { Number(id: UUID(), value: $0, state: .NotPassed) }
            matrixArray.append(contentsOf: subsequenceArray)
            
            matrix = matrixArray.shuffled()
            subsequence = subsequenceArray
            gameTime = GameScreen.GAME_TIME
            
            timer = timer.upstream.autoconnect()
        }
    }
    
    private func selectMatrixNumber(number: Number) {
        if (gameTime < 0) {
            return
        }
        
        if (!subsequence.contains(where: { $0.value == number.value })) {
            gameTime -= 1
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
        
        matrix = matrix.map(
            { matrixNumber in
                matrixNumber.value == number.value ? (
                    subsequence.contains { subsequenceNumber in number.value == subsequenceNumber.value } ?
                    Number(id: matrixNumber.id, value: matrixNumber.value, state: .Passed) :
                        Number(id: matrixNumber.id, value: matrixNumber.value, state: .Failed)
                ) : matrixNumber
            }
        )
        
        subsequence = subsequence.map(
            {
                $0.value == number.value ?
                Number(id: $0.id, value: $0.value, state: .Passed)
                : $0
            }
        )
        
        if (subsequence.filter({ $0.state == .NotPassed }).isEmpty) {
            initializeGame()
        }
    }
}
