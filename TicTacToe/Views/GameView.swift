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
                    
                    Button {
                        viewModel.quitGame()
                        playSound(sound: "sound-tap", type: "mp3")
                        dismiss()
                    } label: {
                        GameButton(title: "Quit", backgroundColor: Color(.systemRed), width: 300)
                    }
                    
                    Text(viewModel.gameStatusText)
                        .padding()
                    
                    if viewModel.game != nil && viewModel.game?.player2Id != "" {
                        Spacer()
                        
                        GameGridView(viewModel: viewModel, screenWidth: geometry.size.width)
                            .onAppear{
                                viewModel.setOpponentId()
                            }
                        
                        Spacer()
                    } else {
                        LoadingView()
                    }

                } //: VSTACK
                PopupMessageView(viewModel: viewModel)
            } //: ZSTACK
        } //: GEOMETRY
        .onAppear{
            viewModel.initializeGame()
        }
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
