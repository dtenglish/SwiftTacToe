//
//  FirebaseService.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/26/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class FirebaseService: ObservableObject {
    
    static let shared = FirebaseService()
    
    @Published var game: Game!
    
    func joinExistingGame(with userId: String) {
        FirebaseReference(.Game)
            .whereField("player2Id", isEqualTo: "")
            .whereField("player1Id", isNotEqualTo: userId)
            .getDocuments { querySnapshot, error in
                
            if error != nil {
                print("Error joining game: ", error!.localizedDescription)
            }
            
            if let gameData = querySnapshot?.documents.first {
                self.game = try? gameData.data(as: Game.self)
                self.game.player2Id = userId
                self.updateGame(self.game)
                self.listenForGameChanges()
            } else {
                self.createNewGame(with: userId)
            }
        }
    }
    
    func createNewGame(with userId: String) {
        print("Creating new game for user: ", userId)
        
        self.game = Game(id: UUID().uuidString, player1Id: userId, player2Id: "", activePlayerId: userId, winningPlayerId: "", rematchPlayerIds: [])
        
        do {
            try FirebaseReference(.Game).document(self.game.id).setData(from: self.game)
        } catch {
            print("Error connecting game to firebase database: ", error.localizedDescription)
        }
    }
    
    func updateGame(_ game: Game) {
        
    }
    
    func listenForGameChanges() {
        
    }
    
    func quitGame() {
        
    }
}
