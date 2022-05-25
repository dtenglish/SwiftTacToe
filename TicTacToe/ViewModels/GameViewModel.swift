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
            game.moves[position] = Move(isPlayer1: true, boardIndex: position)
            
            // Change active user
            
            // Check win conditions
        }
    }
    
}
