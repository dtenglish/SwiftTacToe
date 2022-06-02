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
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
        
    //MARK: - BODY
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing:  5) {
                ForEach(0..<9) { i in
                    ZStack {
                        Circle()
                            .foregroundColor(Color(.systemBlue).opacity(0.7))
                            .frame(width: screenWidth / 3 - 15, height: screenWidth / 3 - 15)
                        if let marker = viewModel.game?.moves[i]?.marker {
                            PlayerMarkerView(imageName: marker)
                        }
                    }
                    .onTapGesture {
                        if viewModel.game?.isActive == true && viewModel.game?.activePlayerId == viewModel.currentUser.id {
                            viewModel.playerMove(for: i)
                            playSound(sound: "sound-rise", type: "mp3")
                        } else {
                            playSound(sound: "sound-tap", type: "mp3")
                        }
                    }
                }
            } //: VGRID
            .padding()
        } //: VSTACK
    }
}
