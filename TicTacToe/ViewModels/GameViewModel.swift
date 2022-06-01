//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
    
    //MARK: - PROPERTIES
    
    @AppStorage("user") private var userData: Data?
    
    @Published var currentUser: User!
    
    @Published var opponenentId: String?
    
    @Published var game: Game? {
        didSet {
            updateGameStatus()
        }
    }
    
    @Published var gameStatusText: String = "Waiting for player..."
    
    @Published var showPopup: Bool = false
    
    @Published var popupTitle: String = ""
    
    @Published var popupMessage: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
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
        
        showPopup = false
        popupTitle = ""
        popupMessage = ""
        
    }
    
    //MARK: - GAME FUNCTIONS
    
    func initializeGame() {
        FirebaseService.shared.startGame(with: currentUser.id)
        
        FirebaseService.shared.$game
            .assign(to: \.game, on: self)
            .store(in: &cancellables)
    }
    
    func playerMove(for position: Int) {
        // Check for game before unwrapping optional
        guard game != nil else { return }
        
        // Check to confirm selected position is unoccupied
        if game?.moves[position] == nil {
        
            // Claim position for active player
            game?.moves[position] = Move(
                player: currentUser.id,
                boardIndex: position,
                marker: currentUser.id == game?.player1Id ? "xmark" : "circle"
            )
            
            // Check win conditions
            checkWinCondition(for: currentUser.id, in: game!.moves)
            checkForDraw(in: game!.moves)
            
            // Change active user
            changeActiveUser()
            
            // Update online game
            FirebaseService.shared.updateGame(game!)
        } else {
            // Indicate to player that move is invalid
            gameStatusText = String("Position already claimed, please select an open space.")
        }
    }
    
    func updateGameStatus() {
        // Check for game before unwrapping optional
        guard game != nil else { return }
        
        if game!.connectedPlayerIds.count < 2 && game!.isActive {
            gameStatusText = "Game Over"
            showPopup = true
            popupTitle = "Opponent has left"
            popupMessage = "Opponent has left the game, please return to the main menu."
            return
        }
        
        // Check for opponent ID before unwrapping optional
        guard opponenentId != nil else { return }
        
        if game!.rematchPlayerIds.contains(opponenentId!) {
            // Inform opponent of rematch request
            popupTitle = "Rematch?"
            popupMessage = "Opponent would like to play again!"
            return
        }
        
        if game?.winningPlayerId == "draw" {
            gameStatusText = "Draw"
            showPopup = true
            popupTitle = "Draw!"
            popupMessage = "It's a draw! Would you like to play again?"
            return
        }
        
        if game?.winningPlayerId == currentUser.id {
            gameStatusText = "You win!"
            showPopup = true
            popupTitle = "Victory!"
            popupMessage = "You win! Would you like to play again?"
            return
        }
        
        if game?.winningPlayerId != currentUser.id && game?.winningPlayerId != "" {
            gameStatusText = "You lose!"
            showPopup = true
            popupTitle = "Defeat!"
            popupMessage = "You lose! Would you like to play again?"
            return
        }
        
        if game?.connectedPlayerIds.count == 2 && game?.activePlayerId == currentUser.id {
            gameStatusText = "Your turn"
        }
        
        if game?.connectedPlayerIds.count == 2 && game?.activePlayerId != currentUser.id {
            gameStatusText = "Opponent's turn"
        }

    }
    
    func changeActiveUser() {
        // Check for game before unwrapping optional
        guard game != nil else { return }
        
        if game?.activePlayerId == game?.player1Id {
            game!.activePlayerId = game!.player2Id
        } else {
            game!.activePlayerId = game!.player1Id
        }
    }
    
    func checkWinCondition(for player: String, in moves: [Move?]) {
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            game?.winningPlayerId = currentUser.id
            game?.activePlayerId = "none"
            return
        }
        
    }
    
    func checkForDraw(in moves: [Move?]) {
        if moves.compactMap({ $0 }).count == 9 && game!.winningPlayerId.isEmpty {
            game?.winningPlayerId = "draw"
            game?.activePlayerId = "none"
            return
        }
        

    }
    
    func resetGame() {
        guard game != nil else {
            return
        }
        
        game!.rematchPlayerIds.append(currentUser.id)
        
        if game?.rematchPlayerIds.count == 1 {
            //reset board status
            game!.moves = Array(repeating: nil, count: 9)
            game!.winningPlayerId = ""
            
            // Swap players
            (game!.player1Id, game!.player2Id) = (game!.player2Id, game!.player1Id)
            game!.activePlayerId = game!.player1Id
            
        } else if game?.rematchPlayerIds.count == 2 {
            game!.rematchPlayerIds = []
        }
        
        FirebaseService.shared.updateGame(game!)
    }
    
    func quitGame() {
        game?.connectedPlayerIds.removeAll(where: {$0 == currentUser.id})
        
        FirebaseService.shared.updateGame(game!)
        
        if game?.connectedPlayerIds.count == 0 {
            FirebaseService.shared.deleteGame()
        }
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
    
    func setOpponentId() {
        // Check for game before unwrapping optional
        guard game != nil else { return }
        
        if game?.player1Id == currentUser.id {
            opponenentId = game!.player2Id
        } else {
            opponenentId = game!.player1Id
        }
    }
}
