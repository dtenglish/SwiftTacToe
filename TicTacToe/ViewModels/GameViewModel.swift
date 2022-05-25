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
    
    func playerMove(for position: Int) {
        // Check to confirm selected position is unoccupied
        if game.moves[position] == nil {
        
            // Claim position for active player
            game.moves[position] = Move(
                isPlayer1: game.activePlayerId == game.player1Id ? true : false,
                boardIndex: position
            )
            
            // Change active user
            changeActiveUser()
            
            // Check win conditions
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
    
}
