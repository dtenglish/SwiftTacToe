//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    //MARK: - PROPERTIES
    
    @AppStorage("user") private var userData: Data?
    
    @Published var currentUser: User!
    
    @Published var game = Game(id: UUID().uuidString, player1Id: "player1", player2Id: "player2", activePlayerId: "player1", winningPlayerId: "", rematchPlayerIds: [])
    
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
    
    init() {
        retrieveUser()
        
        if currentUser == nil {
            createUser()
        }
    }
    
    //MARK: - GAME FUNCTIONS
    
    func playerMove(for position: Int) {
        // Check to confirm selected position is unoccupied
        if game.moves[position] == nil {
        
            // Claim position for active player
            game.moves[position] = Move(
                player: currentUser.id,
                boardIndex: position,
                indicator: currentUser.id == game.player1Id ? "xmark" : "circle"
            )
            
            // Check win conditions
            if checkForDraw(in: game.moves) {
                print("Draw")
            }
            
            if checkWinCondition(for: currentUser.id, in: game.moves) {
                print("\(game.winningPlayerId) wins!")
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
    
    func checkWinCondition(for player: String, in moves: [Move?]) -> Bool {
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            game.winningPlayerId = currentUser.id
            return true
        }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
    //MARK: - USER FUNCTIONS
    
    func retrieveUser() {
        guard let userData = userData else { return }
        
        do {
            currentUser = try JSONDecoder().decode(User.self, from: userData)
            print("Loaded user: ", currentUser!)
        } catch {
            print("Error retrieving user.")
        }
    }
    
    func createUser() {
        currentUser = User()
        do {
            userData = try JSONEncoder().encode(currentUser)
            print("Created user: ", currentUser!)
        } catch {
            print("Error encoding user data.")
        }
    }
}
