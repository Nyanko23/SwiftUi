//
//  ContentView.swift
//  TicTacToe
//
//  Created by Students on 5/3/25.
//

import SwiftUI

enum Player {
    case x, o, none
}

struct ContentView: View {
    @State private var board: [[Player]] = [
        [.none, .none, .none],
        [.none, .none, .none],
        [.none, .none, .none]
    ]
    @State private var currentPlayer: Player = .x
    @State private var gameOver: Bool = false
    @State private var winner: Player? = nil
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .padding()
            
            if gameOver {
                Text(winner == .none ? "It's a tie!" : "\(winner == .x ? "Player 1" : "Player 2") wins!")
                    .font(.title)
                    .padding()
            }
            
            VStack(spacing: 5) {
                ForEach(0..<3) { row in
                    HStack(spacing: 5) {
                        ForEach(0..<3) { col in
                            Button(action: {
                                self.handleTap(row: row, col: col)
                            }) {
                                Text(self.board[row][col] == .none ? "" : (self.board[row][col] == .x ? "X" : "O"))
                                    .frame(width: 100, height: 100)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                            }
                            .disabled(self.board[row][col] != .none || gameOver)
                        }
                    }
                }
            }
            .padding()
            
            Button(action: {
                self.resetGame()
            }) {
                Text("Restart Game")
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(!gameOver)
        }
        .padding()
    }
    
    // Handle tap on the board
    func handleTap(row: Int, col: Int) {
        guard !gameOver else { return }
        if board[row][col] == .none {
            board[row][col] = currentPlayer
            if checkWin(for: currentPlayer) {
                winner = currentPlayer
                gameOver = true
            } else if isBoardFull() {
                winner = .none
                gameOver = true
            } else {
                currentPlayer = (currentPlayer == .x) ? .o : .x
            }
        }
    }
    
    // Check if the board is full
    func isBoardFull() -> Bool {
        return !board.flatMap { $0 }.contains(.none)
    }
    
    // Check if the current player has won
    func checkWin(for player: Player) -> Bool {
        // Check rows
        for row in 0..<3 {
            if board[row][0] == player && board[row][1] == player && board[row][2] == player {
                return true
            }
        }
        
        // Check columns
        for col in 0..<3 {
            if board[0][col] == player && board[1][col] == player && board[2][col] == player {
                return true
            }
        }
        
        // Check diagonals
        if board[0][0] == player && board[1][1] == player && board[2][2] == player {
            return true
        }
        if board[0][2] == player && board[1][1] == player && board[2][0] == player {
            return true
        }
        
        return false
    }
    
    // Reset the game
    func resetGame() {
        board = [
            [.none, .none, .none],
            [.none, .none, .none],
            [.none, .none, .none]
        ]
        currentPlayer = .x
        gameOver = false
        winner = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
