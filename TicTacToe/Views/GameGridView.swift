//
//  GameGrid.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct GameGridView: View {
    
    //MARK: - PROPERTIES
    
    @ObservedObject var viewModel: GameViewModel

    var screenWidth: CGFloat
        
    //MARK: - BODY
    var body: some View {
        VStack {
            LazyVGrid(columns: viewModel.columns, spacing:  5) {
                ForEach(0..<9) { i in
                    ZStack {
                        Circle()
                            .foregroundColor(Color(.systemBlue).opacity(0.7))
                            .frame(width: screenWidth / 3 - 15, height: screenWidth / 3 - 15)
                        if let indicator = viewModel.game?.moves[i]?.indicator {
                            PlayerIndicatorView(imageName: indicator)
                        }
                    }
                    .onTapGesture {
                        if viewModel.game?.activePlayerId == viewModel.currentUser.id {
                            viewModel.playerMove(for: i)
                        } else {
                            print("Not your turn.")
                        }
                    }
                }
            } //: VGRID
            .padding()
        } //: VSTACK
    }
}
