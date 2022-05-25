//
//  GameView.swift
//  TicTacToe
//
//  Created by Daniel Taylor English on 5/25/22.
//

import SwiftUI

struct GameView: View {
    //MARK: - PROPERTIES

    
    //MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Waiting for player...")
                
                Button {
                    // Quit the game
                } label: {
                    GameButton(title: "Quit", backgroundColor: Color(.systemRed))
                }

                Text("Loading View")
                
                Spacer()
                
                GameGridView(screenWidth: geometry.size.width)
            } //: VSTACK
        } //: GEOMETRY
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
