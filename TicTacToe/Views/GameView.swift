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
                if viewModel.game?.player2Id == "" {
                    Text("Waiting for player...")
                }
                
                Button {
                    viewModel.quitGame()
                    playSound(sound: "sound-tap", type: "mp3")
                    isPresented = false
                } label: {
                    GameButton(title: "Quit", backgroundColor: Color(.systemRed))
                }

//                LoadingView()
                
                Spacer()
                
                GameGridView(viewModel: viewModel, screenWidth: geometry.size.width)
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
