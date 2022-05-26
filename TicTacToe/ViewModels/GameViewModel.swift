//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    @Published var game = Game(id: UUID().uuidString, player1Id: "player1", player2Id: "player2", activePlayerId: "player1", moves: Array(repeating: nil, count: 9))
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let winPatterns: Set<Set<Int>> = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    func playerMove(for position: Int) {
        // Check to confirm selected position is unoccupied
        if game.moves[position] == nil {
        
            // Claim position for active player
            game.moves[position] = Move(
                isPlayer1: game.activePlayerId == game.player1Id ? true : false,
                boardIndex: position
            )
            
            // Check win conditions
            if checkForDraw(in: game.moves) {
                print("Draw")
            }
            
            if checkWinCondition(for: true, in: game.moves) {
                print("\(game.activePlayerId) wins!")
            }
            
            // Change active user
            changeActiveUser()
        } else {
            // Indicate to player that move is invalid
            print("Position already claimed.")
        }
    }
    
    func changeActiveUser() {
        if game.activePlayerId == game.player1Id {
            game.activePlayerId = game.player2Id
        } else {
            game.activePlayerId = game.player1Id
        }
    }
    
    func checkWinCondition(for player1: Bool, in moves: [Move?]) -> Bool {
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.isPlayer1 == player1 }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            return true
        }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
}
