//
//  GameView.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct GameView: View {
    //MARK: - PROPERTIES

    @Binding var isPresented: Bool
    @StateObject var viewModel: GameViewModel = GameViewModel()
    
    //MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                Button {
                    viewModel.quitGame()
                    playSound(sound: "sound-tap", type: "mp3")
                    isPresented = false
                } label: {
                    GameButton(title: "Quit", backgroundColor: Color(.systemRed))
                }
                
                Text(viewModel.gameStatusText)
                    .padding()
                
                if viewModel.game != nil && viewModel.game?.player2Id != "" {
                    Spacer()
                    
                    GameGridView(viewModel: viewModel, screenWidth: geometry.size.width)
                    
                    Spacer()
                } else {
                    LoadingView()
                }

            } //: VSTACK
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
