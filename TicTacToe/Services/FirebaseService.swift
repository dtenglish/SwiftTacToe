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
    
    func startGame(with userId: String) {
        // Check if there is an existing game to join, if not create new game
        FirebaseReference(.Game)
            .whereField("player2Id", isEqualTo: "")
            .whereField("player1Id", isNotEqualTo: userId)
            .getDocuments { querySnapshot, error in
                
            if error != nil {
                print("Error starting game: ", error!.localizedDescription)
            }
            
            if let gameData = querySnapshot?.documents.first {
                self.game = try? gameData.data(as: Game.self)
                self.game.player2Id = userId
                self.game.isActive = true
                
                self.updateGame(self.game)
                print("Joined existing game with user: ", self.game.player1Id)
            } else {
                self.createNewGame(with: userId)
            }
                
            self.listenForGameChanges()
        }
    }
    
    func createNewGame(with userId: String) {
        print("Creating new game for user: ", userId)
        
        self.game = Game(id: UUID().uuidString, player1Id: userId, player2Id: "", activePlayerId: userId, winningPlayerId: "", rematchPlayerIds: [], isActive: false)
        
        do {
            try FirebaseReference(.Game).document(self.game.id).setData(from: self.game)
        } catch {
            print("Error connecting game to firebase database: ", error.localizedDescription)
        }
    }
    
    func updateGame(_ game: Game) {
        do {
            try FirebaseReference(.Game).document(game.id).setData(from: game)
        } catch {
            print("Error updating online game: ", error.localizedDescription)
        }
    }
    
    func listenForGameChanges() {
        FirebaseReference(.Game).document(self.game.id).addSnapshotListener { documentSnapshot, error in
            print("Changes received from firebase.")
            
            if error != nil {
                print("Error receiving changes from firebase: ", error!.localizedDescription)
                return
            }
            
            if let snapshot = documentSnapshot {
                self.game = try? snapshot.data(as: Game.self)
            }
        }
        
    }
    
    func deleteGame() {
        guard game != nil else { return }
        FirebaseReference(.Game).document(self.game.id).delete()
        print("Deleting game")
    }
}
