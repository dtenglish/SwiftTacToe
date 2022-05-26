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
    
    func createNewGame() {
        
    }
    
    func joinExistingGame() {
        
    }
}
