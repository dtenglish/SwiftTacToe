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
    
    //MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Waiting for player...")
                
                Button {
                    isPresented = false
                } label: {
                    GameButton(title: "Quit", backgroundColor: Color(.systemRed))
                }

//                LoadingView()
                
                Spacer()
                
                GameGridView(viewModel: GameViewModel(), screenWidth: geometry.size.width)
            } //: VSTACK
        } //: GEOMETRY
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
