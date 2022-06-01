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
    var winningPlayerId: String
    var connectedPlayerIds: [String]
    var rematchPlayerIds: [String]
    
    var isActive: Bool
    
    var moves: [Move?] = Array(repeating: nil, count: 9)
}

struct Move: Codable {
    
    let player: String
    let boardIndex: Int
    
    var marker: String
}
