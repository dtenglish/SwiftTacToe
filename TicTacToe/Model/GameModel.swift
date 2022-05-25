//
//  Model.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import Foundation

struct Game: Codable {
    let id: String
    var player1Id: String
    var player2Id: String
    
    var activePlayerId: String
    
    var moves: [Move?]
}

struct Move: Codable {
    
    let isPlayer1: Bool
    let boardIndex: Int
    
    var playerIndicator: String {
        return isPlayer1 ? "xmark" : "circle"
    }
}
