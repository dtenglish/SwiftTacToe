//
//  GameView.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct GameView: View {
    //MARK: - PROPERTIES

    @StateObject var viewModel: GameViewModel = GameViewModel()
    @Environment(\.dismiss) private var dismiss
    
    //MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    GameButton(title: "Quit", backgroundColor: Color(.systemRed), width: 300, action: {
                        viewModel.quitGame()
                        playSound(sound: "sound-tap", type: "mp3")
                        dismiss()
                    })
                    
                    Text(viewModel.gameStatusText)
                        .padding()
                    
                    if viewModel.game != nil && viewModel.game?.player2Id != "" {
                        Spacer()
                        
                        GameGridView(viewModel: viewModel, screenWidth: geometry.size.width)
                            .onAppear{
                                viewModel.setOpponentId()
                                viewModel.updateGameStatus()
                            }
                        
                        Spacer()
                    } else {
                        LoadingView()
                    }

                } //: VSTACK
                PopupView(viewModel: viewModel)
            } //: ZSTACK
        } //: GEOMETRY
        .onAppear{
            viewModel.initializeGame()
        }
        .onChange(of: viewModel.dismissView) { dismissView in
            if dismissView {
                dismiss()
            }
        }
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
